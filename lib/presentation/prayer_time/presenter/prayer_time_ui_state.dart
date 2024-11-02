import 'package:flutter/widgets.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';

class PrayerTimeUiState extends BaseUiState {
  const PrayerTimeUiState({
    required super.isLoading,
    required super.userMessage,
    required this.notifyMe,
    required this.prayerTime,
    required this.nowTime,
    required this.activeWaqtType,
    required this.nextWaqtType,
    required this.remainingDuration, // Changed to Duration
    required this.remainingTimeProgress,
    required this.totalDuration, // Added totalDuration
    this.context,
  });

  factory PrayerTimeUiState.empty() {
    return const PrayerTimeUiState(
      isLoading: false,
      userMessage: '',
      notifyMe: false,
      context: null,
      prayerTime: null,
      nowTime: null,
      activeWaqtType: null,
      nextWaqtType: null,
      remainingDuration: Duration(), // Initialize with zero duration
      totalDuration: Duration(),
      remainingTimeProgress: 0,
    );
  }

  final bool notifyMe;
  final DateTime? nowTime;
  final PrayerTimeEntity? prayerTime;
  final BuildContext? context;
  final WaqtType? activeWaqtType;
  final WaqtType? nextWaqtType;
  final Duration remainingDuration; // Changed from String to Duration
  final Duration totalDuration;
  final double remainingTimeProgress;

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
    );
  }
}
