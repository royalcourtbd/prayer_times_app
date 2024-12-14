import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_modal_sheet.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_radio_list_tile.dart';

class JuristicMethodBottomSheet extends StatelessWidget {
  JuristicMethodBottomSheet({super.key, required this.presenter});

  final SettingsPagePresenter presenter;

  static Future<void> show(
      {required BuildContext context,
      required SettingsPagePresenter presenter}) async {
    final JuristicMethodBottomSheet juristicMethodBottomSheet =
        await Future.microtask(
      () => JuristicMethodBottomSheet(presenter: presenter),
    );

    if (context.mounted) {
      await context.showBottomSheet(juristicMethodBottomSheet, context);
    }
  }

  late final PrayerTimePresenter prayerTimePresenter =
      locate<PrayerTimePresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: presenter,
      builder: () {
        return CustomModalSheet(
          theme: theme,
          bottomSheetTitle: 'Juristic Method',
          children: [
            CustomRadioListTile(
              title: 'Hanafi',
              subtitle: 'Late Asr Prayer',
              isSelected:
                  presenter.currentUiState.selectedJuristicMethod == 'Hanafi',
              onTap: () => presenter.onJuristicMethodChanged(
                method: 'Hanafi',
                onPrayerTimeUpdateRequired: () =>
                    prayerTimePresenter.refreshLocationAndPrayerTimes(),
              ),
            ),
            CustomRadioListTile(
              title: 'Shafi, Maliki, Hanbali',
              subtitle: 'Earlier Asr Prayer',
              isSelected:
                  presenter.currentUiState.selectedJuristicMethod == 'Shafi',
              onTap: () => presenter.onJuristicMethodChanged(
                method: 'Shafi',
                onPrayerTimeUpdateRequired: () =>
                    prayerTimePresenter.refreshLocationAndPrayerTimes(),
              ),
            ),
          ],
        );
      },
    );
  }
}
