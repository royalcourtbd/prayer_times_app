// prayer_time_ui_state.dart
import 'package:flutter/widgets.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/fasting_state.dart';

class PrayerTimeUiState extends BaseUiState {
  const PrayerTimeUiState({
    required super.isLoading,
    required super.userMessage,
    required this.notifyMe,
    required this.prayerTime,
    required this.nowTime,
    required this.activeWaqtType,
    required this.nextWaqtType,
    required this.remainingDuration,
    required this.remainingTimeProgress,
    required this.totalDuration,
    required this.fastingRemainingDuration,
    required this.fastingTotalDuration,
    required this.fastingProgress,
    required this.fastingState,
    required this.prayerTrackers,
    this.context,
  });

  factory PrayerTimeUiState.empty() {
    return PrayerTimeUiState(
      isLoading: false,
      userMessage: '',
      notifyMe: false,
      context: null,
      prayerTime: null,
      nowTime: DateTime.now(),
      activeWaqtType: null,
      nextWaqtType: null,
      remainingDuration: const Duration(),
      totalDuration: const Duration(),
      remainingTimeProgress: 0,
      fastingRemainingDuration: const Duration(),
      fastingTotalDuration: const Duration(),
      fastingProgress: 0,
      fastingState: FastingState.none,
      prayerTrackers: const [],
    );
  }

  final bool notifyMe;
  final DateTime? nowTime;
  final PrayerTimeEntity? prayerTime;
  final BuildContext? context;
  final WaqtType? activeWaqtType;
  final WaqtType? nextWaqtType;
  final Duration remainingDuration;
  final Duration totalDuration;
  final double remainingTimeProgress;
  final List<PrayerTrackerModel> prayerTrackers;

  // New fasting related states
  final Duration fastingRemainingDuration;
  final Duration fastingTotalDuration;
  final double fastingProgress;
  final FastingState fastingState;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        notifyMe,
        prayerTime,
        nowTime,
        activeWaqtType,
        nextWaqtType,
        remainingDuration,
        totalDuration,
        remainingTimeProgress,
        fastingRemainingDuration,
        fastingTotalDuration,
        fastingProgress,
        fastingState,
        prayerTrackers,
        context,
      ];

  PrayerTimeUiState copyWith({
    bool? isLoading,
    String? userMessage,
    bool? notifyMe,
    BuildContext? context,
    PrayerTimeEntity? prayerTime,
    DateTime? nowTime,
    WaqtType? activeWaqtType,
    WaqtType? nextWaqtType,
    Duration? remainingDuration,
    Duration? totalDuration,
    double? remainingTimeProgress,
    Duration? fastingRemainingDuration,
    Duration? fastingTotalDuration,
    double? fastingProgress,
    FastingState? fastingState,
    List<PrayerTrackerModel>? prayerTrackers,
  }) {
    return PrayerTimeUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      notifyMe: notifyMe ?? this.notifyMe,
      context: context ?? this.context,
      prayerTime: prayerTime ?? this.prayerTime,
      nowTime: nowTime ?? this.nowTime,
      activeWaqtType: activeWaqtType ?? this.activeWaqtType,
      nextWaqtType: nextWaqtType ?? this.nextWaqtType,
      remainingDuration: remainingDuration ?? this.remainingDuration,
      totalDuration: totalDuration ?? this.totalDuration,
      remainingTimeProgress:
          remainingTimeProgress ?? this.remainingTimeProgress,
      fastingRemainingDuration:
          fastingRemainingDuration ?? this.fastingRemainingDuration,
      fastingTotalDuration: fastingTotalDuration ?? this.fastingTotalDuration,
      fastingProgress: fastingProgress ?? this.fastingProgress,
      fastingState: fastingState ?? this.fastingState,
      prayerTrackers: prayerTrackers ?? this.prayerTrackers,
    );
  }
}
