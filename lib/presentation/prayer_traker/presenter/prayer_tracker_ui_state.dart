// prayer_time_ui_state.dart
import 'package:flutter/widgets.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';

class PrayerTrackerUiState extends BaseUiState {
  const PrayerTrackerUiState({
    required super.isLoading,
    required super.userMessage,
    this.context,
  });

  factory PrayerTrackerUiState.empty() {
    return const PrayerTrackerUiState(
      isLoading: false,
      userMessage: '',
      context: null,
    );
  }

  final BuildContext? context;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        context,
      ];

  PrayerTrackerUiState copyWith({
    bool? isLoading,
    String? userMessage,
    BuildContext? context,
  }) {
    return PrayerTrackerUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      context: context ?? this.context,
    );
  }
}
