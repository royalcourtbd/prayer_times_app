// prayer_time_ui_state.dart

import 'package:salat_times/core/base/base_ui_state.dart';
import 'package:salat_times/data/models/prayer_tracker_model.dart';

// lib/presentation/prayer_tracker/presenter/prayer_tracker_ui_state.dart

class PrayerTrackerUiState extends BaseUiState {
  const PrayerTrackerUiState({
    required super.isLoading,
    required super.userMessage,
    required this.selectedDate,
    required this.prayerTrackers,
    this.dragOffset = 0.0,
  });

  final DateTime selectedDate;
  final List<PrayerTrackerModel> prayerTrackers;
  final double dragOffset;

  factory PrayerTrackerUiState.empty() {
    return PrayerTrackerUiState(
      isLoading: false,
      userMessage: '',
      selectedDate: DateTime.now(),
      prayerTrackers: const [],
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        selectedDate,
        prayerTrackers,
        dragOffset,
      ];

  PrayerTrackerUiState copyWith({
    bool? isLoading,
    String? userMessage,
    DateTime? selectedDate,
    List<PrayerTrackerModel>? prayerTrackers,
    double? dragOffset,
  }) {
    return PrayerTrackerUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      selectedDate: selectedDate ?? this.selectedDate,
      prayerTrackers: prayerTrackers ?? this.prayerTrackers,
      dragOffset: dragOffset ?? this.dragOffset,
    );
  }
}
