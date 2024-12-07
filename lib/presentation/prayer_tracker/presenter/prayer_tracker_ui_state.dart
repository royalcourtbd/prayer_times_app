// prayer_time_ui_state.dart
import 'package:flutter/widgets.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';

// lib/presentation/prayer_tracker/presenter/prayer_tracker_ui_state.dart

class PrayerTrackerUiState extends BaseUiState {
  const PrayerTrackerUiState({
    required super.isLoading,
    required super.userMessage,
    required this.selectedDate,
    required this.prayerTrackers,
    this.context,
  });

  final BuildContext? context;
  final DateTime selectedDate;
  final List<PrayerTrackerModel> prayerTrackers;

  factory PrayerTrackerUiState.empty() {
    return PrayerTrackerUiState(
      isLoading: false,
      userMessage: '',
      context: null,
      selectedDate: DateTime.now(),
      prayerTrackers: const [],
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        context,
        selectedDate,
        prayerTrackers,
      ];

  PrayerTrackerUiState copyWith({
    bool? isLoading,
    String? userMessage,
    BuildContext? context,
    DateTime? selectedDate,
    List<PrayerTrackerModel>? prayerTrackers,
  }) {
    return PrayerTrackerUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      context: context ?? this.context,
      selectedDate: selectedDate ?? this.selectedDate,
      prayerTrackers: prayerTrackers ?? this.prayerTrackers,
    );
  }
}
