// prayer_time_presenter.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/domain/service/time_service.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';
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
    getPrayerTimes();
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // Prayer Time Related Methods
  Future<void> getPrayerTimes() async {
    await executeTaskWithLoading(() async {
      await parseDataFromEitherWithUserMessage<PrayerTimeEntity>(
        task: () => _getPrayerTimesUseCase.execute(
          latitude: 23.8103,
          longitude: 90.4125,
        ),
        onDataLoaded: (data) {
          uiState.value = currentUiState.copyWith(
            prayerTime: data,
          );
          _updateActiveWaqt();
          _updateRemainingTime();
        },
      );
    });
  }

  DateTime? _getWaqtTime(WaqtType type) {
    if (currentUiState.prayerTime == null) return null;

    switch (type) {
      case WaqtType.fajr:
        return currentUiState.prayerTime!.fajr;
      case WaqtType.dhuhr:
        return currentUiState.prayerTime!.dhuhr;
      case WaqtType.asr:
        return currentUiState.prayerTime!.asr;
      case WaqtType.maghrib:
        return currentUiState.prayerTime!.maghrib;
      case WaqtType.isha:
        return currentUiState.prayerTime!.isha;
    }
  }

  // Active Waqt Management
  void _updateActiveWaqt() {
    final DateTime now =
        currentUiState.nowTime ?? _timeService.getCurrentTime();
    WaqtType? activeType;
    WaqtType? nextType;

    // Get all prayer times for today
    final List<MapEntry<WaqtType, DateTime?>> todayPrayers = WaqtType.values
        .map((type) => MapEntry(type, _getWaqtTime(type)))
        .where((entry) => entry.value != null)
        .toList();

    // Sort prayers by time
    todayPrayers.sort((a, b) => a.value!.compareTo(b.value!));

    // Find current and next prayer
    for (int i = 0; i < todayPrayers.length; i++) {
      if (now.isBefore(todayPrayers[i].value!)) {
        activeType = i > 0 ? todayPrayers[i - 1].key : todayPrayers.last.key;
        nextType = todayPrayers[i].key;
        break;
      }
    }

    // If we're after the last prayer of the day
    if (activeType == null) {
      activeType = todayPrayers.last.key;
      nextType = todayPrayers.first.key;
    }

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
    final DateTime now =
        currentUiState.nowTime ?? _timeService.getCurrentTime();

    if (currentWaqtTime == null || nextWaqtTime == null) {
      uiState.value = currentUiState.copyWith(
        remainingDuration: const Duration(),
        totalDuration: const Duration(),
        remainingTimeProgress: 0,
      );
      return;
    }

    final Duration totalDuration = nextWaqtTime.difference(currentWaqtTime);
    final Duration remainingDuration = nextWaqtTime.difference(now);

    // Calculate progress (100 means full, 0 means empty)
    // When prayer time starts, progress will be 100 and decrease to 0
    final double progress =
        ((totalDuration.inSeconds - remainingDuration.inSeconds) /
                totalDuration.inSeconds) *
            100;

    uiState.value = currentUiState.copyWith(
      remainingDuration: remainingDuration,
      totalDuration: totalDuration,
      remainingTimeProgress: progress.clamp(0, 100),
    );
  }

  // Timer Management
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      uiState.value = currentUiState.copyWith(
        nowTime: _timeService.getCurrentTime(),
      );
      _updateActiveWaqt();
      _updateRemainingTime();
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

  // Formatted Time Getters
  String getFormattedRemainingTime() {
    final Duration remaining = currentUiState.remainingDuration;
    if (remaining == Duration.zero) return '--:--:--';

    final int hours = remaining.inHours;
    final int minutes = remaining.inMinutes.remainder(60);
    final int seconds = remaining.inSeconds.remainder(60);

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String getRemainingTimeText() {
    if (currentUiState.activeWaqtType == null) return '';
    return 'Remaining ${currentUiState.activeWaqtType?.displayName ?? ''}';
  }

  String getCurrentTime() {
    final DateTime now =
        currentUiState.nowTime ?? _timeService.getCurrentTime();
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
