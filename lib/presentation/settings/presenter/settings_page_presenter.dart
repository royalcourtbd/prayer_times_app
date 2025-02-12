import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/flutter_toast/debouncer.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/country_entity.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_countries_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_juristic_method_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/search_countries_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/update_juristic_method_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/settings/widgets/juristic_method_bottom_sheet.dart';
import 'package:qibla_and_prayer_times/presentation/settings/widgets/select_location_bottomsheet.dart';

class SettingsPagePresenter extends BasePresenter<SettingsPageUiState> {
  final GetJuristicMethodUseCase _getJuristicMethodUseCase;
  final UpdateJuristicMethodUseCase _updateJuristicMethodUseCase;
  final GetCountriesUseCase _getCountriesUseCase;
  final SearchCountriesUseCase _searchCountriesUseCase;

  SettingsPagePresenter(
    this._getJuristicMethodUseCase,
    this._updateJuristicMethodUseCase,
    this._getCountriesUseCase,
    this._searchCountriesUseCase,
  );

  final Obs<SettingsPageUiState> uiState = Obs(SettingsPageUiState.empty());
  SettingsPageUiState get currentUiState => uiState.value;

  final PrayerTimePresenter _prayerTimePresenter =
      locate<PrayerTimePresenter>();

  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  // Add to SettingsPagePresenter class
  final _searchDebouncer = Debouncer(milliseconds: 500);

  @override
  void onInit() {
    _loadJuristicMethod();
    _loadCountries();
    super.onInit();
  }

  Future<void> _loadJuristicMethod() async {
    await executeTaskWithLoading(() async {
      await parseDataFromEitherWithUserMessage(
        task: () => _getJuristicMethodUseCase.execute(),
        onDataLoaded: (String method) {
          if (method.isNotEmpty) {
            uiState.value =
                currentUiState.copyWith(selectedJuristicMethod: method);
          }
        },
      );
    });
  }

  Future<void> onJuristicMethodChanged({
    required String method,
    VoidCallback? onPrayerTimeUpdateRequired,
  }) async {
    await executeTaskWithLoading(() async {
      await parseDataFromEitherWithUserMessage(
        task: () => _updateJuristicMethodUseCase.execute(method: method),
        onDataLoaded: (_) async {
          uiState.value =
              currentUiState.copyWith(selectedJuristicMethod: method);
          onPrayerTimeUpdateRequired?.call();
        },
      );
    });
  }

  String showLocationName() {
    return _prayerTimePresenter.currentUiState.location?.placeName ?? '';
  }

  void showJuristicMethodBottomSheet() {
    JuristicMethodBottomSheet.show(
      context: currentUiState.context!,
      presenter: this,
    );
  }

  void showSelectLocationBottomSheet() {
    SelectLocationBottomsheet.show(
      context: currentUiState.context!,
    );
  }

  void onManualLocationSelected({required bool isManualLocationSelected}) {
    uiState.value = currentUiState.copyWith(
        isManualLocationSelected: isManualLocationSelected);
  }

  void onUseCurrentLocationSelected() async {
    onManualLocationSelected(isManualLocationSelected: false);
    await _prayerTimePresenter.loadLocationAndPrayerTimes();
  }

  void onSaveLocationSelected() {
    currentUiState.context!.navigatorPop();
    clearControllers();
  }

  void clearControllers() {
    countryController.clear();
    cityController.clear();
  }

  Future<void> get loadCountries => _loadCountries();

  Future<void> _loadCountries() async {
    await executeTaskWithLoading(() async {
      await parseDataFromEitherWithUserMessage(
        task: () => _getCountriesUseCase.execute(),
        onDataLoaded: (List<CountryNameEntity> countries) {
          uiState.value = currentUiState.copyWith(countries: countries);
        },
      );
    });
  }

  Future<void> onSearchQueryChanged({required String searchQuery}) async {
    _searchDebouncer.run(() async {
      countryController.text = searchQuery;

      if (searchQuery.isEmpty) {
        await _loadCountries();
        return;
      }

      await executeTaskWithLoading(() async {
        await parseDataFromEitherWithUserMessage(
          task: () => _searchCountriesUseCase.execute(searchQuery: searchQuery),
          onDataLoaded: (List<CountryNameEntity> countries) {
            uiState.value = currentUiState.copyWith(countries: countries);
          },
        );
      });
    });
  }

  Future<void> onCitySearchQueryChanged({required String searchQuery}) async {
    _searchDebouncer.run(() {
      cityController.text = searchQuery;

      final filteredCities = currentUiState.selectedCountryCities
          .where((city) =>
              city.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();

      uiState.value = currentUiState.copyWith(
        selectedCountryCities: filteredCities,
      );
    });
  }

  void onCountrySelected({required CountryNameEntity country}) {
    clearControllers();
    uiState.value = currentUiState.copyWith(
      selectedCountry: country.name,
      selectedCountryCities: country.cities,
      selectedCity: '',
    );
    countryController.text = country.name;
  }

  void onCitySelected({required CityNameEntity city}) {
    clearControllers();
    uiState.value = currentUiState.copyWith(
      selectedCity: city.name,
    );
  }

  void updateContext(BuildContext context) {
    uiState.value = currentUiState.copyWith(context: context);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(message: currentUiState.userMessage);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
