// prayer_time_ui_state.dart
import 'package:flutter/widgets.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';

class SettingsPageUiState extends BaseUiState {
  const SettingsPageUiState({
    required super.isLoading,
    required super.userMessage,
    this.context,
    required this.selectedJuristicMethod,
  });

  final BuildContext? context;
  final String selectedJuristicMethod;

  factory SettingsPageUiState.empty() {
    return const SettingsPageUiState(
      isLoading: false,
      userMessage: '',
      context: null,
      selectedJuristicMethod: 'Shafi',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        context,
        selectedJuristicMethod,
      ];

  SettingsPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    BuildContext? context,
    String? selectedJuristicMethod,
  }) {
    return SettingsPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      context: context ?? this.context,
      selectedJuristicMethod:
          selectedJuristicMethod ?? this.selectedJuristicMethod,
    );
  }
}
