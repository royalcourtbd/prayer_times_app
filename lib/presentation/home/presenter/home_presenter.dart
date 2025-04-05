import 'dart:async';
import 'dart:developer';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:prayer_times/core/base/base_presenter.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/di/service_locator.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/domain/entities/device_info_entity.dart';
import 'package:prayer_times/domain/entities/location_entity.dart';
import 'package:prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:prayer_times/domain/service/time_service.dart';
import 'package:prayer_times/domain/service/waqt_calculation_service.dart';
import 'package:prayer_times/domain/usecases/check_notification_permission_usecase.dart';
import 'package:prayer_times/domain/usecases/get_active_waqt_usecase.dart';
import 'package:prayer_times/domain/usecases/get_device_info_usecase.dart';
import 'package:prayer_times/domain/usecases/get_location_usecase.dart';
import 'package:prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:prayer_times/domain/usecases/get_remaining_time_usecase.dart';
import 'package:prayer_times/domain/usecases/request_notification_permission_usecase.dart';
import 'package:prayer_times/presentation/common/notification_denied_dialog.dart';
import 'package:prayer_times/presentation/main/presenter/main_presenter.dart';
import 'package:prayer_times/presentation/home/models/fasting_state.dart';
import 'package:prayer_times/presentation/home/models/waqt.dart';
import 'package:prayer_times/presentation/home/presenter/home_ui_state.dart';
import 'package:prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';

class HomePresenter extends BasePresenter<HomeUiState> {
  final GetLocationUseCase _getLocationUseCase;
  final GetPrayerTimesUseCase _getPrayerTimesUseCase;
  final GetActiveWaqtUseCase _getActiveWaqtUseCase;
  final GetRemainingTimeUseCase _getRemainingTimeUseCase;
  final TimeService _timeService;
  final GetDeviceInfoUsecase _getDeviceInfoUsecase;
  final WaqtCalculationService _waqtCalculationService;
  final RequestNotificationPermissionUsecase
      _requestNotificationPermissionUsecase;
  final CheckNotificationPermissionUsecase _checkNotificationPermissionUsecase;
  StreamSubscription<DateTime>? _timeSubscription;

  final ScrollController prayerTimesScrollController = ScrollController();
  // ইউজার ম্যানুয়ালি স্ক্রল করেছে কিনা তা ট্র্যাক করা
  bool _userScrolled = false;

  HomePresenter(
    this._getLocationUseCase,
    this._getPrayerTimesUseCase,
    this._getActiveWaqtUseCase,
    this._getRemainingTimeUseCase,
    this._timeService,
    this._waqtCalculationService,
    this._getDeviceInfoUsecase,
    this._requestNotificationPermissionUsecase,
    this._checkNotificationPermissionUsecase,
  );

  final Obs<HomeUiState> uiState = Obs<HomeUiState>(HomeUiState.empty());
  HomeUiState get currentUiState => uiState.value;

  late final PrayerTrackerPresenter prayerTrackerPresenter =
      locate<PrayerTrackerPresenter>();

  late final MainPresenter mainPresenter = locate<MainPresenter>();

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    fetchDeviceInfo();
    checkNotificationPermission();

    prayerTimesScrollController.addListener(_onUserScroll);
  }

  @override
  void onClose() {
    prayerTimesScrollController.removeListener(_onUserScroll);
    prayerTimesScrollController.dispose();
    _timeSubscription?.cancel();
    super.onClose();
  }

  Future<void> checkNotificationPermission() async {
    await parseDataFromEitherWithUserMessage<bool>(
      task: () => _checkNotificationPermissionUsecase.execute(),
      showLoading: false,
      onDataLoaded: (bool hasPermission) {
        if (!hasPermission) {
          // পারমিশন নেই, রিকোয়েস্ট করুন
          log('requestNotificationPermission');
          requestNotificationPermission();
        } else {
          log('hasPermission: $hasPermission');
          // পারমিশন আছে, প্রয়োজনীয় সেটআপ করুন (যেমন ডিভাইস রেজিস্ট্রেশন)
          // আপনি ইতিমধ্যেই onInit-এ fetchDeviceInfo() কল করেছেন, যা ঠিক আছে
        }
      },
    );
  }

  // নতুন মেথড যোগ করুন
  Future<void> requestNotificationPermission() async {
    await parseDataFromEitherWithUserMessage<void>(
      task: () => _requestNotificationPermissionUsecase.execute(
        onGrantedOrSkippedForNow: () {
          // পারমিশন দেওয়া হয়েছে
          log('onGrantedOrSkippedForNow');
        },
        onDenied: () {
          // পারমিশন দেওয়া হয়নি
          log('onDenied ');
          NotificationDeniedDialog.show(
            context: Get.context!,
            onSubmit: () async {
              openNotificationSettings();
            },
          );
        },
      ),
      showLoading: false,
      onDataLoaded: (_) {
        // এখানে কিছু করার দরকার নেই
      },
    );
  }

  void openNotificationSettings() {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  Future<void> loadLocationAndPrayerTimes() async {
    await _fetchLocationAndPrayerTimes(forceRemote: false);
  }

  Future<void> refreshLocationAndPrayerTimes() async {
    try {
      await toggleLoading(loading: true);

      bool isConnected = await checkInternetConnection();
      if (!isConnected) {
        await toggleLoading(loading: false);
        showMessage(message: 'No internet connection');
        return;
      }

      await _fetchLocationAndPrayerTimes(forceRemote: true);
    } catch (e) {
      log('error in refreshLocationAndPrayerTimes: $e');
      await toggleLoading(loading: false);
    } finally {
      await toggleLoading(loading: false);
    }
  }

  StreamSubscription<Either<String, List<DeviceInfoEntity>>>?
      _deviceInfoSubscription;

  Future<void> fetchDeviceInfo() async {
    await executeTaskWithLoading(() async {
      await handleStreamEvents<List<DeviceInfoEntity>>(
        stream: _getDeviceInfoUsecase.execute(),
        onData: (List<DeviceInfoEntity> data) {
          // log('deviceInfo: $data');
        },
        subscription: _deviceInfoSubscription,
      );
    });
  }

  Future<void> _fetchLocationAndPrayerTimes({required bool forceRemote}) async {
    await executeTaskWithLoading(() async {
      await parseDataFromEitherWithUserMessage<LocationEntity>(
        task: () => _getLocationUseCase.execute(forceRemote: forceRemote),
        onDataLoaded: (LocationEntity location) async {
          await getPrayerTimes(location: location);
        },
      );
    });
  }

  Future<void> getPrayerTimes({required LocationEntity location}) async {
    await executeTaskWithLoading(() async {
      await parseDataFromEitherWithUserMessage<PrayerTimeEntity>(
        task: () => _getPrayerTimesUseCase.execute(
          latitude: location.latitude,
          longitude: location.longitude,
          date: _timeService.getCurrentTime(),
        ),
        onDataLoaded: (PrayerTimeEntity data) {
          uiState.value =
              currentUiState.copyWith(prayerTime: data, location: location);

          _updateAllStates();
          initializeTracker();
        },
      );
    });
  }

  void _updateAllStates() {
    _updateActiveWaqt();
    _updateRemainingTime();
    _updateFastingState();
  }

  void _startTimer() {
    _timeSubscription = _timeService.currentTimeStream.listen((now) {
      uiState.value = currentUiState.copyWith(
        nowTime: now,
        hijriDate: _getHijriDate(now),
      );
      _updateAllStates();
    });
  }

  String _getHijriDate(DateTime date) {
    final HijriCalendar hijri = HijriCalendar.fromDate(date);
    return '${hijri.format(hijri.hYear, hijri.hMonth, hijri.hDay, 'dd MMMM yyyy')} H';
  }

  List<WaqtViewModel> get waqtList {
    final List<WaqtViewModel> list = [];
    if (currentUiState.prayerTime == null) return list;

    for (final type in WaqtType.values) {
      list.add(WaqtViewModel(
        type: type,
        time: _waqtCalculationService.getWaqtTime(
          type,
          currentUiState.prayerTime!,
        ),
        isActive: type == currentUiState.activeWaqtType,
      ));
    }

    return list;
  }

  String _formatDuration(Duration duration) {
    if (duration == Duration.zero) return '--:--';

    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);
    final int seconds = duration.inSeconds.remainder(60);

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String getFormattedRemainingTime() =>
      _formatDuration(currentUiState.remainingDuration);

  String getRemainingTimeText() {
    if (currentUiState.activeWaqtType == null) return '';
    return currentUiState.activeWaqtType?.displayName ?? '';
  }

  String getFormattedFastingRemainingTime() =>
      _formatDuration(currentUiState.fastingRemainingDuration);

  String getFastingTitle() => currentUiState.fastingState.displayName;

  double getFastingProgress() => currentUiState.fastingProgress;

  String getSehriTime() =>
      getFormattedTimeForFasting(currentUiState.prayerTime?.startFajr);

  String getIftarTime() =>
      getFormattedTimeForFasting(currentUiState.prayerTime?.startMaghrib);

  String getCurrentTime() => getFormattedTime(_getCurrentDateTime());

  DateTime _getCurrentDateTime() =>
      currentUiState.nowTime ?? _timeService.getCurrentTime();

  /// প্রার্থনা সময় আপডেট করে, অ্যাক্টিভ প্রার্থনা কোনটি সেটি নির্ধারণ করতে
  Future<void> _updateActiveWaqt() async {
    if (currentUiState.prayerTime == null) return;

    await parseDataFromEitherWithUserMessage(
      task: () => _getActiveWaqtUseCase.execute(
        prayerTime: currentUiState.prayerTime!,
        currentTime: _getCurrentDateTime(),
      ),
      onDataLoaded: (result) {
        if (result.activeWaqt != currentUiState.activeWaqtType ||
            result.nextWaqt != currentUiState.nextWaqtType) {
          uiState.value = currentUiState.copyWith(
            activeWaqtType: result.activeWaqt,
            nextWaqtType: result.nextWaqt,
          );

          // অ্যাক্টিভ প্রার্থনা পরিবর্তন হয়েছে, সুতরাং forceScroll=true দিয়ে স্ক্রোল করা
          scrollToActiveWaqt(null, true);
        }
      },
    );
  }

  Future<void> _updateRemainingTime() async {
    if (currentUiState.activeWaqtType == null ||
        currentUiState.nextWaqtType == null) {
      _resetRemainingTime();
      return;
    }

    final DateTime? currentWaqtTime = _waqtCalculationService.getWaqtTime(
      currentUiState.activeWaqtType!,
      currentUiState.prayerTime!,
    );
    final DateTime? nextWaqtTime = _waqtCalculationService.getWaqtTime(
      currentUiState.nextWaqtType!,
      currentUiState.prayerTime!,
    );

    if (currentWaqtTime == null || nextWaqtTime == null) {
      _resetRemainingTime();
      return;
    }

    await parseDataFromEitherWithUserMessage(
      task: () => _getRemainingTimeUseCase.execute(
        currentWaqtTime: currentWaqtTime,
        nextWaqtTime: nextWaqtTime,
        currentTime: _getCurrentDateTime(),
      ),
      onDataLoaded: (result) {
        uiState.value = currentUiState.copyWith(
          remainingDuration: result.remainingDuration,
          totalDuration: result.totalDuration,
          remainingTimeProgress: result.progress,
        );
      },
    );
  }

  void _resetRemainingTime() {
    uiState.value = currentUiState.copyWith(
      remainingDuration: const Duration(),
      totalDuration: const Duration(),
      remainingTimeProgress: 0,
    );
  }

  void _updateFastingState() {
    if (currentUiState.prayerTime == null || currentUiState.nowTime == null) {
      uiState.value = currentUiState.copyWith(
        fastingRemainingDuration: const Duration(),
        fastingTotalDuration: const Duration(),
        fastingProgress: 0,
        fastingState: FastingState.none,
      );
      return;
    }

    final DateTime now = currentUiState.nowTime!;
    final DateTime sehri = currentUiState.prayerTime!.startFajr;
    final DateTime iftar = currentUiState.prayerTime!.startMaghrib;

    Duration remainingDuration;
    Duration totalDuration;
    FastingState state;

    if (now.isAfter(sehri) && now.isBefore(iftar)) {
      remainingDuration = iftar.difference(now);
      totalDuration = iftar.difference(sehri);
      state = FastingState.fasting;
    } else if (now.isAfter(iftar)) {
      final DateTime nextSehri = sehri.add(const Duration(days: 1));
      remainingDuration = nextSehri.difference(now);
      totalDuration = nextSehri.difference(iftar);
      state = FastingState.sehri;
    } else {
      remainingDuration = sehri.difference(now);
      totalDuration = sehri.difference(
        sehri.subtract(const Duration(hours: 8)),
      );
      state = FastingState.sehri;
    }

    final double progress =
        _calculateProgress(totalDuration, remainingDuration);

    uiState.value = currentUiState.copyWith(
      fastingRemainingDuration: remainingDuration,
      fastingTotalDuration: totalDuration,
      fastingProgress: progress,
      fastingState: state,
    );
  }

  double _calculateProgress(Duration total, Duration remaining) {
    return (remaining.inSeconds / total.inSeconds * 100).clamp(0, 100);
  }

  void initializeTracker() {
    if (currentUiState.prayerTime != null) {
      prayerTrackerPresenter.initializePrayerTracker(
        prayerTimeEntity: currentUiState.prayerTime!,
      );
    }
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(message: currentUiState.userMessage);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  /// Scroll to the active waqt in the center of the screen
  void scrollToActiveWaqt([BuildContext? context, bool forceScroll = false]) {
    try {
      // If the user is scrolling and forceScroll is not true, do not scroll
      if (_userScrolled && !forceScroll) return;

      if (waqtList.isEmpty || !prayerTimesScrollController.hasClients) return;

      // Find the active waqt
      int activeIndex = waqtList.indexWhere((waqt) => waqt.isActive);
      if (activeIndex == -1) return;

      // Get the actual screen width
      double screenWidth =
          prayerTimesScrollController.position.viewportDimension;

      // If BuildContext is provided, use the correct screen width
      if (context != null) {
        screenWidth = MediaQuery.of(context).size.width;
      }

      // Create the position of each item
      double offset = 0;
      double leftPadding = twentyPx; // ListView এর padding
      double rightMargin = twelvePx; // আইটেমের right margin

      // Calculate the position and width of each item
      List<double> itemPositions = [];
      List<double> itemWidths = [];

      // Add padding at the beginning
      offset += leftPadding;

      // Calculate the position of each item
      for (int i = 0; i < waqtList.length; i++) {
        if (waqtList[i].type == WaqtType.duha) continue; // duha স্কিপ করা

        bool isSpecial = waqtList[i].type == WaqtType.sunrise;
        // Instead of calculating directly, use percentWidth
        double widthPercentage = isSpecial ? 25 : 43;
        double width = (screenWidth * widthPercentage) / 100;

        itemPositions.add(offset);
        itemWidths.add(width);

        offset += width + rightMargin;
      }

      // Check if the active item is within the bounds
      int visibleActiveIndex = activeIndex;
      // duha আইটেম সরিয়ে দেওয়ার কারণে কিছু ইনডেক্স বদলাতে পারে
      for (int i = 0; i < activeIndex; i++) {
        if (waqtList[i].type == WaqtType.duha) {
          visibleActiveIndex--;
        }
      }

      // Check if the active item is within the bounds
      if (visibleActiveIndex >= itemPositions.length) return;

      double activePosition = itemPositions[visibleActiveIndex];
      double activeWidth = itemWidths[visibleActiveIndex];

      // Calculate the scroll position to center the active item
      double scrollTo = activePosition - (screenWidth / 2) + (activeWidth / 2);

      // Check if the scroll is within the bounds
      scrollTo = scrollTo.clamp(
          0.0, prayerTimesScrollController.position.maxScrollExtent);

      // Smooth scroll to the active waqt
      prayerTimesScrollController.animateTo(
        scrollTo,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
      );
    } catch (e) {
      log('Error in scrollToActiveWaqt: $e');
    }
  }

  // When user goes to other page and comes back to this page, scroll to the active waqt
  void scrollToActiveWaqtWithDelay([BuildContext? context]) {
    // If the user is scrolling, set the userScrolled to true
    _userScrolled = false;

    // After the UI is rendered, scroll to the active waqt
    Future.delayed(Duration(milliseconds: 500), () {
      scrollToActiveWaqt(context);
    });
  }

  // If the user is scrolling, set the userScrolled to true
  void _onUserScroll() {
    // If the user is scrolling, set the userScrolled to true
    if (prayerTimesScrollController.position.isScrollingNotifier.value) {
      _userScrolled = true;
    }
  }

  // When user goes to other page and comes back to this page, reset the user scroll
  void resetUserScroll() {
    _userScrolled = false;
  }
}
