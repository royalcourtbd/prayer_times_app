// prayer_time_ui_state.dart
import 'package:flutter/widgets.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';

class SettingsPageUiState extends BaseUiState {
  const SettingsPageUiState({
    required super.isLoading,
    required super.userMessage,
    this.context,
  });

  final BuildContext? context;

  factory SettingsPageUiState.empty() {
    return const SettingsPageUiState(
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

  SettingsPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    BuildContext? context,
  }) {
    return SettingsPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      context: context ?? this.context,
    );
  }
}
