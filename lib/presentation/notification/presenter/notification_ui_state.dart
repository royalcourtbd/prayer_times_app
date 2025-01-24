import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';

class NotificationUiState extends BaseUiState {
  const NotificationUiState({
    required super.isLoading,
    required super.userMessage,
    this.context,
  });

  final BuildContext? context;

  factory NotificationUiState.empty() {
    return const NotificationUiState(
      isLoading: false,
      userMessage: '',
      context: null,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        context,
      ];

  NotificationUiState copyWith({
    bool? isLoading,
    String? userMessage,
    BuildContext? context,
  }) {
    return NotificationUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      context: context ?? this.context,
    );
  }
}
