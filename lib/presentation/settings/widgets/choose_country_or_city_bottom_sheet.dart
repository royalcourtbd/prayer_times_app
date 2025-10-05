import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/di/service_locator.dart';
import 'package:salat_times/core/external_libs/presentable_widget_builder.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/domain/entities/country_entity.dart';
import 'package:salat_times/presentation/common/custom_modal_sheet.dart';
import 'package:salat_times/presentation/common/custom_text_input_field.dart';
import 'package:salat_times/presentation/settings/presenter/settings_page_presenter.dart';

class ChooseCountryOrCityBottomSheet extends StatelessWidget {
  ChooseCountryOrCityBottomSheet({super.key, required this.isCountrySelection});
  final bool isCountrySelection;
  final SettingsPagePresenter settingsPresenter =
      locate<SettingsPagePresenter>();

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
    return PresentableWidgetBuilder(
        presenter: settingsPresenter,
        builder: () {
          return CustomModalSheet(
            theme: theme,
            bottomSheetTitle:
                isCountrySelection ? 'Select Country' : 'Select City',
            constraints: BoxConstraints(maxHeight: 90.percentHeight),
            children: [
              if (isCountrySelection) ...[
                CustomTextInputField(
                  theme: theme,
                  controller: settingsPresenter.countryController,
                  hintText: 'Search from list',
                  onChanged: (value) {
                    settingsPresenter.onSearchQueryChanged(searchQuery: value);
                  },
                ),
                gapH10,
                SizedBox(
                  height: 70.percentHeight,
                  child: settingsPresenter.currentUiState.countries.isEmpty
                      ? const Center(child: Text('No countries found'))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              settingsPresenter.currentUiState.countries.length,
                          itemBuilder: (context, index) {
                            final CountryNameEntity country = settingsPresenter
                                .currentUiState.countries[index];

                            return ListTile(
                              title: Text(country.name),
                              trailing: settingsPresenter
                                          .currentUiState.selectedCountry ==
                                      country.name
                                  ? Icon(Icons.check,
                                      color: context.color.primaryColor)
                                  : null,
                              onTap: () {
                                settingsPresenter.onCountrySelected(
                                    country: country);
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
                      controller: settingsPresenter.cityController,
                      hintText: 'Search from list',
                      onChanged: (value) {
                        settingsPresenter.onCitySearchQueryChanged(
                            searchQuery: value);
                      },
                    ),
                    gapH10,
                    SizedBox(
                      height: 70.percentHeight,
                      child: settingsPresenter
                              .currentUiState.selectedCountryCities.isEmpty
                          ? const Center(child: Text('No Cities found'))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: settingsPresenter
                                  .currentUiState.selectedCountryCities.length,
                              itemBuilder: (context, index) {
                                final CityNameEntity city = settingsPresenter
                                    .currentUiState
                                    .selectedCountryCities[index];
                                return ListTile(
                                  title: Text(city.name),
                                  trailing: settingsPresenter
                                              .currentUiState.selectedCity ==
                                          city.name
                                      ? Icon(Icons.check,
                                          color: context.color.primaryColor)
                                      : null,
                                  onTap: () {
                                    settingsPresenter.onCitySelected(
                                        city: city);
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
        });
  }
}
