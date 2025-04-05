// prayer_time_ui_state.dart
import 'package:prayer_times/core/base/base_ui_state.dart';
import 'package:prayer_times/domain/entities/country_entity.dart';

class SettingsPageUiState extends BaseUiState {
  const SettingsPageUiState({
    required super.isLoading,
    required super.userMessage,
    required this.selectedJuristicMethod,
    required this.selectedCountry,
    required this.isManualLocationSelected,
    required this.countries,
    required this.selectedCountryCities,
    required this.selectedCity,
  });

  final String selectedJuristicMethod;
  final String selectedCountry;
  final String selectedCity;
  final bool isManualLocationSelected;
  final List<CountryNameEntity> countries;
  final List<CityNameEntity> selectedCountryCities;

  factory SettingsPageUiState.empty() {
    return const SettingsPageUiState(
      isLoading: false,
      userMessage: '',
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
    String? selectedJuristicMethod,
    String? selectedCountry,
    String? selectedCity,
    bool? isManualLocationSelected,
    List<CountryNameEntity>? countries,
    List<CityNameEntity>? selectedCountryCities,
  }) {
    return SettingsPageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
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
