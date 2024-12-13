// prayer_time_ui_state.dart
import 'package:flutter/widgets.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';

class SettingsPageUiState extends BaseUiState {
  const SettingsPageUiState({
    required super.isLoading,
    required super.userMessage,
    this.context,
    required this.selectedJuristicMethod,
    required this.selectedCountry,
    required this.isManualLocationSelected,
  });

  final BuildContext? context;
  final String selectedJuristicMethod;
  final String selectedCountry;
  final bool isManualLocationSelected;
  factory SettingsPageUiState.empty() {
    return const SettingsPageUiState(
      isLoading: false,
      userMessage: '',
      context: null,
      selectedJuristicMethod: '',
      selectedCountry: '',
      isManualLocationSelected: false,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        context,
        selectedJuristicMethod,
        selectedCountry,
        isManualLocationSelected,
      ];

  SettingsPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    BuildContext? context,
    String? selectedJuristicMethod,
    String? selectedCountry,
    bool? isManualLocationSelected,
  }) {
    return SettingsPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      context: context ?? this.context,
      selectedJuristicMethod:
          selectedJuristicMethod ?? this.selectedJuristicMethod,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isManualLocationSelected:
          isManualLocationSelected ?? this.isManualLocationSelected,
    );
  }
}
