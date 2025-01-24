import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/country_entity.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_modal_sheet.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_text__input_field.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_presenter.dart';

class ChooseCountryOrCityBottomSheet extends StatelessWidget {
  ChooseCountryOrCityBottomSheet({super.key, required this.isCountrySelection});
  final bool isCountrySelection;
  final SettingsPagePresenter presenter = locate<SettingsPagePresenter>();

  static Future<void> show(
      {required BuildContext context, required bool isCountrySelection}) async {
    final ChooseCountryOrCityBottomSheet chooseCountryOrCityBottomSheet =
        await Future.microtask(() => ChooseCountryOrCityBottomSheet(
            isCountrySelection: isCountrySelection));
    if (context.mounted) {
      final presenter = locate<SettingsPagePresenter>();
      if (isCountrySelection) {
        presenter.clearControllers();
        await presenter.loadCountries;
      }
      await context.showBottomSheet(chooseCountryOrCityBottomSheet, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomModalSheet(
      theme: theme,
      bottomSheetTitle: isCountrySelection ? 'Select Country' : 'Select City',
      constraints: BoxConstraints(maxHeight: 90.percentHeight),
      children: [
        if (isCountrySelection) ...[
          CustomTextInputField(
            theme: theme,
            controller: presenter.countryController,
            hintText: 'Search from list',
            onChanged: (value) {
              presenter.onSearchQueryChanged(searchQuery: value);
            },
          ),
          gapH10,
          SizedBox(
            height: 70.percentHeight,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: presenter.currentUiState.countries.length,
              itemBuilder: (context, index) {
                final CountryNameEntity country =
                    presenter.currentUiState.countries[index];
                return ListTile(
                  title: Text(country.name),
                  trailing:
                      presenter.currentUiState.selectedCountry == country.name
                          ? Icon(Icons.check, color: context.color.primaryColor)
                          : null,
                  onTap: () {
                    presenter.onCountrySelected(country: country);
                    context.navigatorPop();
                  },
                );
              },
            ),
          ),
        ] else ...[
          Column(
            children: [
              CustomTextInputField(
                theme: theme,
                controller: presenter.cityController,
                hintText: 'Search from list',
                onChanged: (value) {
                  presenter.onCitySearchQueryChanged(searchQuery: value);
                },
              ),
              gapH10,
              SizedBox(
                height: 70.percentHeight,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      presenter.currentUiState.selectedCountryCities.length,
                  itemBuilder: (context, index) {
                    final CityNameEntity city =
                        presenter.currentUiState.selectedCountryCities[index];
                    return ListTile(
                      title: Text(city.name),
                      trailing: presenter.currentUiState.selectedCity ==
                              city.name
                          ? Icon(Icons.check, color: context.color.primaryColor)
                          : null,
                      onTap: () {
                        presenter.onCitySelected(city: city);
                        context.navigatorPop();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
