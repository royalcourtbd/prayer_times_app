import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';
import 'package:qibla_and_prayer_times/domain/entities/location_entity.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/presentation/home/models/fasting_state.dart';
import 'package:qibla_and_prayer_times/presentation/home/models/waqt.dart';

class HomeUiState extends BaseUiState {
  const HomeUiState({
    required super.isLoading,
    required super.userMessage,
    required this.nowTime,
    required this.prayerTime,
    required this.activeWaqtType,
    required this.nextWaqtType,
    required this.remainingDuration,
    required this.totalDuration,
    required this.remainingTimeProgress,
    required this.prayerTrackers,
    required this.fastingRemainingDuration,
    required this.fastingTotalDuration,
    required this.fastingProgress,
    required this.fastingState,
    required this.location,
    required this.hijriDate,
  });

  factory HomeUiState.empty() {
    return HomeUiState(
      isLoading: false,
      userMessage: '',
      nowTime: DateTime.now(),
      prayerTime: null,
      activeWaqtType: null,
      nextWaqtType: null,
      remainingDuration: const Duration(),
      totalDuration: const Duration(),
      remainingTimeProgress: 0,
      prayerTrackers: const [],
      fastingRemainingDuration: const Duration(),
      fastingTotalDuration: const Duration(),
      fastingProgress: 0,
      fastingState: FastingState.none,
      location: null,
      hijriDate: '',
    );
  }

  final DateTime? nowTime;
  final PrayerTimeEntity? prayerTime;
  final WaqtType? activeWaqtType;
  final WaqtType? nextWaqtType;
  final Duration remainingDuration;
  final Duration totalDuration;
  final double remainingTimeProgress;
  final List<PrayerTrackerModel> prayerTrackers;
  final Duration fastingRemainingDuration;
  final Duration fastingTotalDuration;
  final double fastingProgress;
  final FastingState fastingState;
  final LocationEntity? location;
  final String? hijriDate;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        nowTime,
        prayerTime,
        activeWaqtType,
        nextWaqtType,
        remainingDuration,
        totalDuration,
        remainingTimeProgress,
        prayerTrackers,
        fastingRemainingDuration,
        fastingTotalDuration,
        fastingProgress,
        fastingState,
        location,
        hijriDate,
      ];

  HomeUiState copyWith({
    bool? isLoading,
    String? userMessage,
    DateTime? nowTime,
    PrayerTimeEntity? prayerTime,
    WaqtType? activeWaqtType,
    WaqtType? nextWaqtType,
    Duration? remainingDuration,
    Duration? totalDuration,
    double? remainingTimeProgress,
    List<PrayerTrackerModel>? prayerTrackers,
    Duration? fastingRemainingDuration,
    Duration? fastingTotalDuration,
    double? fastingProgress,
    FastingState? fastingState,
    LocationEntity? location,
    String? hijriDate,
  }) {
    return HomeUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      nowTime: nowTime ?? this.nowTime,
      prayerTime: prayerTime ?? this.prayerTime,
      activeWaqtType: activeWaqtType ?? this.activeWaqtType,
      nextWaqtType: nextWaqtType ?? this.nextWaqtType,
      remainingDuration: remainingDuration ?? this.remainingDuration,
      totalDuration: totalDuration ?? this.totalDuration,
      remainingTimeProgress:
          remainingTimeProgress ?? this.remainingTimeProgress,
      prayerTrackers: prayerTrackers ?? this.prayerTrackers,
      fastingRemainingDuration:
          fastingRemainingDuration ?? this.fastingRemainingDuration,
      fastingTotalDuration: fastingTotalDuration ?? this.fastingTotalDuration,
      fastingProgress: fastingProgress ?? this.fastingProgress,
      fastingState: fastingState ?? this.fastingState,
      location: location ?? this.location,
      hijriDate: hijriDate ?? this.hijriDate,
    );
  }
}
