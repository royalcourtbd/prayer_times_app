import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';

class PrayerTimeUiState extends BaseUiState {
  const PrayerTimeUiState({
    required super.isLoading,
    required super.userMessage,
    required this.notifyMe,
    this.context,
  });

  factory PrayerTimeUiState.empty() {
    return const PrayerTimeUiState(
      isLoading: false,
      userMessage: '',
      notifyMe: false,
      context: null,
    );
  }

  final bool notifyMe;
  final BuildContext? context;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        notifyMe,
        context,
      ];

  PrayerTimeUiState copyWith({
    bool? isLoading,
    String? userMessage,
    bool? notifyMe,
    BuildContext? context,
  }) {
    return PrayerTimeUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      notifyMe: notifyMe ?? this.notifyMe,
      context: context ?? this.context,
    );
  }
}
