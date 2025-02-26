// lib/presentation/prayer_time/presenter/prayer_time_presenter.dart

import 'dart:async';
import 'package:hijri/hijri_calendar.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/location_entity.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/domain/service/time_service.dart';
import 'package:qibla_and_prayer_times/domain/service/waqt_calculation_service.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_active_waqt_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_location_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_remaining_time_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/fasting_state.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';

class PrayerTimePresenter extends BasePresenter<PrayerTimeUiState> {
  final GetLocationUseCase _getLocationUseCase;
  final GetPrayerTimesUseCase _getPrayerTimesUseCase;
  final GetActiveWaqtUseCase _getActiveWaqtUseCase;
  final GetRemainingTimeUseCase _getRemainingTimeUseCase;
  final TimeService _timeService;
  final WaqtCalculationService _waqtCalculationService;

  StreamSubscription<DateTime>? _timeSubscription;

  PrayerTimePresenter(
    this._getPrayerTimesUseCase,
    this._getActiveWaqtUseCase,
    this._getRemainingTimeUseCase,
    this._timeService,
    this._waqtCalculationService,
    this._getLocationUseCase,
  );

  final Obs<PrayerTimeUiState> uiState = Obs(PrayerTimeUiState.empty());
  PrayerTimeUiState get currentUiState => uiState.value;
  late final PrayerTrackerPresenter _prayerTrackerPresenter =
      locate<PrayerTrackerPresenter>();

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  @override
  void onClose() {
    _timeSubscription?.cancel();
    super.onClose();
  }

  Future<void> loadLocationAndPrayerTimes() async {
    await _fetchLocationAndPrayerTimes(forceRemote: false);
  }

  Future<void> refreshLocationAndPrayerTimes() async {
    await _fetchLocationAndPrayerTimes(forceRemote: true);
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
    if (duration == Duration.zero) return '--:--:--';

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

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);

    showMessage(message: currentUiState.userMessage);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  DateTime _getCurrentDateTime() =>
      currentUiState.nowTime ?? _timeService.getCurrentTime();

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
    return ((total.inSeconds - remaining.inSeconds) / total.inSeconds * 100)
        .clamp(0, 100);
  }

  void initializeTracker() {
    if (currentUiState.prayerTime != null) {
      _prayerTrackerPresenter.initializePrayerTracker(
        prayerTimeEntity: currentUiState.prayerTime!,
      );
    }
  }
}
