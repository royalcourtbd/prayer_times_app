// prayer_time_ui_state.dart
import 'package:flutter/widgets.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/domain/entities/country.dart';

class SettingsPageUiState extends BaseUiState {
  const SettingsPageUiState({
    required super.isLoading,
    required super.userMessage,
    this.context,
    required this.selectedJuristicMethod,
    required this.selectedCountry,
    required this.isManualLocationSelected,
    required this.countries,
    required this.selectedCountryCities,
    required this.selectedCity,
  });

  final BuildContext? context;
  final String selectedJuristicMethod;
  final String selectedCountry;
  final String selectedCity;
  final bool isManualLocationSelected;
  final List<Country> countries;
  final List<City> selectedCountryCities;

  factory SettingsPageUiState.empty() {
    return const SettingsPageUiState(
      isLoading: false,
      userMessage: '',
      context: null,
      selectedJuristicMethod: '',
      selectedCountry: '',
      selectedCity: '',
      isManualLocationSelected: false,
      countries: [],
      selectedCountryCities: [],
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        context,
        selectedJuristicMethod,
        selectedCountry,
        selectedCity,
        isManualLocationSelected,
        countries,
        selectedCountryCities,
      ];

  SettingsPageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    BuildContext? context,
    String? selectedJuristicMethod,
    String? selectedCountry,
    String? selectedCity,
    bool? isManualLocationSelected,
    List<Country>? countries,
    List<City>? selectedCountryCities,
  }) {
    return SettingsPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      context: context ?? this.context,
      selectedJuristicMethod:
          selectedJuristicMethod ?? this.selectedJuristicMethod,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
      isManualLocationSelected:
          isManualLocationSelected ?? this.isManualLocationSelected,
      countries: countries ?? this.countries,
      selectedCountryCities:
          selectedCountryCities ?? this.selectedCountryCities,
    );
  }
}
