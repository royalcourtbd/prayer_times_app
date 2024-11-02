// prayer_time_presenter.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/domain/service/time_service.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/prayer_tracker.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/fasting_state.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_ui_state.dart';

class PrayerTimePresenter extends BasePresenter<PrayerTimeUiState> {
  final GetPrayerTimesUseCase _getPrayerTimesUseCase;
  final TimeService _timeService;

  PrayerTimePresenter(this._getPrayerTimesUseCase, this._timeService);
  final Obs<PrayerTimeUiState> uiState = Obs(PrayerTimeUiState.empty());

  PrayerTimeUiState get currentUiState => uiState.value;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    getPrayerTimes().then((_) {
      _initializePrayerTracker();
    });
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();

    super.onClose();
  }

  // Prayer Time Related Methods
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
          uiState.value = currentUiState.copyWith(
            prayerTime: data,
          );
          _updateActiveWaqt();
          _updateRemainingTime();
          _updateFastingState();
        },
      );
    });
  }

  void _initializePrayerTracker() {
    final DateTime now = _getCurrentDateTime();
    final List<PrayerTrackerModel> trackers = [];

    for (final type in WaqtType.values) {
      final DateTime? prayerTime = _getWaqtTime(type);

      final bool isSelectable = prayerTime != null && prayerTime.isBefore(now);

      trackers.add(PrayerTrackerModel(
        type: type,
        isSelectable: isSelectable,
      ));
    }

    uiState.value = currentUiState.copyWith(
      prayerTrackers: trackers,
    );
  }

  void togglePrayerStatus(WaqtType type) {
    print('togglePrayerStatus called for: $type');
    if (!currentUiState.prayerTrackers[type.index].isSelectable) {
      print('Prayer is not selectable');
      return;
    }

    final List<PrayerTrackerModel> trackers =
        List<PrayerTrackerModel>.from(currentUiState.prayerTrackers);
    final currentStatus = trackers[type.index].status;

    print('Current status: $currentStatus');

    final newStatus = currentStatus == PrayerStatus.none
        ? PrayerStatus.completed
        : PrayerStatus.none;

    print('New status: $newStatus');

    trackers[type.index] = trackers[type.index].copyWith(
      status: newStatus,
    );

    uiState.value = currentUiState.copyWith(
      prayerTrackers: trackers,
    );

    print('Updated trackers: ${uiState.value.prayerTrackers}');
  }

  DateTime _getCurrentDateTime() =>
      currentUiState.nowTime ?? _timeService.getCurrentTime();

  DateTime? _getWaqtTime(WaqtType type) {
    final PrayerTimeEntity? prayerTime = currentUiState.prayerTime;
    if (prayerTime == null) return null;

    switch (type) {
      case WaqtType.fajr:
        return prayerTime.fajr;
      case WaqtType.dhuhr:
        return prayerTime.dhuhr;
      case WaqtType.asr:
        return prayerTime.asr;
      case WaqtType.maghrib:
        return prayerTime.maghrib;
      case WaqtType.isha:
        return prayerTime.isha;
    }
  }

  // Active Waqt Management
  void _updateActiveWaqt() {
    final DateTime now = _getCurrentDateTime();
    WaqtType? activeType;
    WaqtType? nextType;

    // Get all prayer times for today and tomorrow
    final List<MapEntry<WaqtType, DateTime?>> prayers = [];

    // Add today's prayers
    prayers.addAll(WaqtType.values
        .map((WaqtType type) => MapEntry(type, _getWaqtTime(type)))
        .where((MapEntry<WaqtType, DateTime?> entry) => entry.value != null));

    // Add tomorrow's Fajr
    final DateTime? tomorrowFajr =
        _getWaqtTime(WaqtType.fajr)?.add(const Duration(days: 1));
    if (tomorrowFajr != null) {
      prayers.add(MapEntry(WaqtType.fajr, tomorrowFajr));
    }

    // Sort prayers by time
    prayers.sort(
        (MapEntry<WaqtType, DateTime?> a, MapEntry<WaqtType, DateTime?> b) =>
            a.value!.compareTo(b.value!));

    // Find current and next prayer
    for (int i = 0; i < prayers.length; i++) {
      if (now.isBefore(prayers[i].value!)) {
        activeType = i > 0 ? prayers[i - 1].key : prayers.last.key;
        nextType = prayers[i].key;
        break;
      }
    }

    // Update state
    if (activeType != currentUiState.activeWaqtType ||
        nextType != currentUiState.nextWaqtType) {
      uiState.value = currentUiState.copyWith(
        activeWaqtType: activeType,
        nextWaqtType: nextType,
      );
    }
  }

  // Remaining Time Management
  void _updateRemainingTime() {
    if (currentUiState.activeWaqtType == null ||
        currentUiState.nextWaqtType == null) {
      uiState.value = currentUiState.copyWith(
        remainingDuration: const Duration(),
        totalDuration: const Duration(),
        remainingTimeProgress: 0,
      );
      return;
    }

    final DateTime? currentWaqtTime =
        _getWaqtTime(currentUiState.activeWaqtType!);
    final DateTime? nextWaqtTime = _getWaqtTime(currentUiState.nextWaqtType!);
    final DateTime now = _getCurrentDateTime();

    if (currentWaqtTime == null || nextWaqtTime == null) {
      uiState.value = currentUiState.copyWith(
        remainingDuration: const Duration(),
        totalDuration: const Duration(),
        remainingTimeProgress: 0,
      );
      return;
    }

    // Handle case when next prayer is tomorrow
    DateTime adjustedNextWaqtTime = nextWaqtTime;
    if (nextWaqtTime.isBefore(now)) {
      adjustedNextWaqtTime = nextWaqtTime.add(const Duration(days: 1));
    }

    final Duration totalDuration =
        adjustedNextWaqtTime.difference(currentWaqtTime);
    final Duration remainingDuration = adjustedNextWaqtTime.difference(now);

    // Ensure remaining duration is never negative
    final Duration validRemainingDuration =
        remainingDuration.isNegative ? const Duration() : remainingDuration;

    // Calculate progress (100 means full, 0 means empty)
    final double progress =
        _calculateProgress(totalDuration, validRemainingDuration);

    uiState.value = currentUiState.copyWith(
      remainingDuration: validRemainingDuration,
      totalDuration: totalDuration,
      remainingTimeProgress: progress,
    );
  }

  // Fasting State Management
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
    final DateTime sehri = currentUiState.prayerTime!.fajr;
    final DateTime iftar = currentUiState.prayerTime!.maghrib;

    Duration remainingDuration;
    Duration totalDuration;
    FastingState state;

    // During fasting (between Sehri and Iftar)
    if (now.isAfter(sehri) && now.isBefore(iftar)) {
      remainingDuration = iftar.difference(now);
      totalDuration = iftar.difference(sehri);
      state = FastingState.fasting;
    }
    // After Iftar, waiting for next Sehri
    else if (now.isAfter(iftar)) {
      final DateTime nextSehri = sehri.add(const Duration(days: 1));
      remainingDuration = nextSehri.difference(now);
      totalDuration = nextSehri.difference(iftar);
      state = FastingState.sehri;
    }
    // Before Sehri
    else {
      remainingDuration = sehri.difference(now);
      totalDuration =
          sehri.difference(sehri.subtract(const Duration(hours: 8)));
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

  // Timer Management

  void _updateAllStates() {
    _updateActiveWaqt();
    _updateRemainingTime();
    _updateFastingState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      uiState.value = currentUiState.copyWith(
        nowTime: _timeService.getCurrentTime(),
      );
      _updateAllStates();
    });
  }

  // Waqt List Generation
  List<WaqtViewModel> get waqtList {
    final List<WaqtViewModel> list = [];

    for (final type in WaqtType.values) {
      list.add(WaqtViewModel(
        type: type,
        time: _getWaqtTime(type),
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

  // Formatted Time Getters
  String getFormattedRemainingTime() =>
      _formatDuration(currentUiState.remainingDuration);

  String getRemainingTimeText() {
    if (currentUiState.activeWaqtType == null) return '';
    return currentUiState.activeWaqtType?.displayName ?? '';
  }

  // Fasting Time Getters
  String getFormattedFastingRemainingTime() =>
      _formatDuration(currentUiState.fastingRemainingDuration);

  String getFastingTitle() {
    return currentUiState.fastingState.displayName;
  }

  double getFastingProgress() {
    return currentUiState.fastingProgress;
  }

  // Utility Methods
  String getSehriTime() => getFormattedTime(currentUiState.prayerTime?.fajr);
  String getIftarTime() => getFormattedTime(currentUiState.prayerTime?.maghrib);

  String getCurrentTime() {
    final DateTime now = _getCurrentDateTime();
    return getFormattedTime(now);
  }

  // UI Helper Methods
  void toggleNotifyMe(bool value) {
    uiState.value = currentUiState.copyWith(notifyMe: value);
    addUserMessage('Notify me every prayer time: $value');
  }

  void updateContext(BuildContext context) {
    uiState.value = currentUiState.copyWith(context: context);
  }

  // Base Presenter Overrides
  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(
        message: currentUiState.userMessage, context: currentUiState.context);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
