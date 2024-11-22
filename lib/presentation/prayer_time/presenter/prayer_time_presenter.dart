// lib/presentation/prayer_time/presenter/prayer_time_presenter.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_tracker_entity.dart';
import 'package:qibla_and_prayer_times/domain/service/time_service.dart';
import 'package:qibla_and_prayer_times/domain/service/waqt_calculation_service.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_active_waqt_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_remaining_time_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_notification_settings_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/update_notification_settings_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/fasting_state.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_ui_state.dart';

class PrayerTimePresenter extends BasePresenter<PrayerTimeUiState> {
  final GetPrayerTimesUseCase _getPrayerTimesUseCase;
  final GetActiveWaqtUseCase _getActiveWaqtUseCase;
  final GetRemainingTimeUseCase _getRemainingTimeUseCase;
  final TimeService _timeService;
  final WaqtCalculationService _waqtCalculationService;
  final GetNotificationSettingsUseCase _getNotificationSettingsUseCase;
  final UpdateNotificationSettingsUseCase _updateNotificationSettingsUseCase;
  StreamSubscription<DateTime>? _timeSubscription;

  PrayerTimePresenter(
    this._getPrayerTimesUseCase,
    this._getActiveWaqtUseCase,
    this._getRemainingTimeUseCase,
    this._timeService,
    this._waqtCalculationService,
    this._getNotificationSettingsUseCase,
    this._updateNotificationSettingsUseCase,
  );

  final Obs<PrayerTimeUiState> uiState = Obs(PrayerTimeUiState.empty());
  PrayerTimeUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    super.onInit();
    _loadNotificationSettings();
    getPrayerTimes().then((_) {
      _initializePrayerTracker();
    });
    _startTimer();
  }

  @override
  void onClose() {
    _timeSubscription?.cancel();
    super.onClose();
  }

  Future<void> getPrayerTimes() async {
    const double latitude = 23.8103;
    const double longitude = 90.4125;

    await executeTaskWithLoading(() async {
      await parseDataFromEitherWithUserMessage<PrayerTimeEntity>(
        task: () => _getPrayerTimesUseCase.execute(
          latitude: latitude,
          longitude: longitude,
        ),
        onDataLoaded: (PrayerTimeEntity data) {
          uiState.value = currentUiState.copyWith(prayerTime: data);
          _updateAllStates();
        },
      );
    });
  }

  void _initializePrayerTracker() {
    final DateTime now = _getCurrentDateTime();
    final List<PrayerTrackerModel> trackers = [];

    for (final type in WaqtType.values) {
      final DateTime? prayerTime = _waqtCalculationService.getWaqtTime(
        type,
        currentUiState.prayerTime!,
      );
      final bool isSelectable = prayerTime != null && prayerTime.isBefore(now);

      trackers.add(PrayerTrackerModel(
        id: type.toString(),
        createdAt: now,
        updatedAt: now,
        type: type,
        isSelectable: isSelectable,
      ));
    }

    uiState.value = currentUiState.copyWith(prayerTrackers: trackers);
  }

  void togglePrayerStatus({required WaqtType type}) {
    if (!currentUiState.prayerTrackers[type.index].isSelectable) {
      addUserMessage('Prayer time is not yet reached');
      return;
    }

    final List<PrayerTrackerModel> trackers =
        List<PrayerTrackerModel>.from(currentUiState.prayerTrackers);
    final PrayerStatus currentStatus = trackers[type.index].status;

    final PrayerStatus newStatus = currentStatus == PrayerStatus.none
        ? PrayerStatus.completed
        : PrayerStatus.none;

    trackers[type.index] = trackers[type.index].copyWith(
      status: newStatus,
      updatedAt: _getCurrentDateTime(),
    );

    uiState.value = currentUiState.copyWith(prayerTrackers: trackers);
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

  void toggleNotifyMe({required bool value}) async {
    await parseDataFromEitherWithUserMessage(
      task: () => _updateNotificationSettingsUseCase.execute(isEnabled: value),
      onDataLoaded: (_) {
        uiState.value = currentUiState.copyWith(notifyMe: value);
        addUserMessage('Notify me every prayer time: $value');
      },
    );
  }

  void updateContext({required BuildContext context}) {
    uiState.value = currentUiState.copyWith(context: context);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    if (currentUiState.context != null) {
      showMessage(
        message: currentUiState.userMessage,
        context: currentUiState.context!,
      );
    }
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  Future<void> _loadNotificationSettings() async {
    await parseDataFromEitherWithUserMessage(
      task: () => _getNotificationSettingsUseCase.execute(),
      onDataLoaded: (bool isEnabled) {
        uiState.value = currentUiState.copyWith(notifyMe: isEnabled);
      },
    );
  }
}
