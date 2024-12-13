import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/animate_do/slides.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_button.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_modal_sheet.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_radio_list_tile.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_text_field.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_presenter.dart';

class SelectLocationBottomsheet extends StatelessWidget {
  SelectLocationBottomsheet({super.key});

  final SettingsPagePresenter presenter = locate<SettingsPagePresenter>();

  static Future<void> show({required BuildContext context}) async {
    final SelectLocationBottomsheet selectLocationBottomsheet =
        await Future.microtask(
      () => SelectLocationBottomsheet(),
    );

    if (context.mounted) {
      await context.showBottomSheet(selectLocationBottomsheet, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: presenter,
      builder: () {
        return AnimatedPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          duration: const Duration(milliseconds: 200),
          child: CustomModalSheet(
            theme: theme,
            bottomSheetTitle: 'Set Your Location',
            children: [
              CustomRadioListTile(
                title: 'Use Current Location',
                subtitle: 'Dhaka, Bangladesh',
                isSelected: !presenter.currentUiState.isManualLocationSelected,
                onTap: () {
                  presenter.onManualLocationSelected(
                      isManualLocationSelected: false);
                },
              ),
              gapH25,
              CustomRadioListTile(
                title: 'Select Location Manually',
                isSelected: presenter.currentUiState.isManualLocationSelected,
                onTap: () {
                  presenter.onManualLocationSelected(
                      isManualLocationSelected: true);
                },
              ),
              if (presenter.currentUiState.isManualLocationSelected) ...[
                gapH10,
                SlideInUp(
                  delay: const Duration(milliseconds: 50),
                  child: CustomTextInputField(
                    theme: theme,
                    title: 'Select Country',
                    controller: TextEditingController(),
                    hintText: 'Country Name',
                  ),
                ),
                gapH25,
                SlideInUp(
                  delay: const Duration(milliseconds: 50),
                  child: CustomTextInputField(
                    theme: theme,
                    title: 'Select City',
                    controller: TextEditingController(),
                    hintText: 'City Name',
                  ),
                ),
              ],
              gapH25,
              CustomButton(
                title: 'Save',
                onPressed: () {},
                horizontalPadding: 0,
              ),
            ],
          ),
        );
      },
    );
  }
}
