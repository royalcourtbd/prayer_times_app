import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';

class PrayerTimeUiState extends BaseUiState {
  const PrayerTimeUiState({
    required super.isLoading,
    required super.userMessage,
    required this.notifyMe,
    required this.prayerTime,
    this.context,
  });

  factory PrayerTimeUiState.empty() {
    return const PrayerTimeUiState(
      isLoading: false,
      userMessage: '',
      notifyMe: false,
      context: null,
      prayerTime: null,
    );
  }

  final bool notifyMe;
  final PrayerTimeEntity? prayerTime;
  final BuildContext? context;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        notifyMe,
        prayerTime,
        context,
      ];

  PrayerTimeUiState copyWith({
    bool? isLoading,
    String? userMessage,
    bool? notifyMe,
    BuildContext? context,
    PrayerTimeEntity? prayerTime,
  }) {
    return PrayerTimeUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      notifyMe: notifyMe ?? this.notifyMe,
      context: context ?? this.context,
      prayerTime: prayerTime ?? this.prayerTime,
    );
  }
}
