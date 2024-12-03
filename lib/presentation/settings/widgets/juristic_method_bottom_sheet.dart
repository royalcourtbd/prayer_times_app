import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/settings/widgets/juristic_method_radio_item.dart';

class JuristicMethodBottomSheet extends StatelessWidget {
  const JuristicMethodBottomSheet({super.key, required this.presenter});

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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: presenter,
      builder: () {
        return Container(
          decoration: BoxDecoration(
            color: context.color.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(twentyPx),
              topRight: Radius.circular(twentyPx),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(twentyPx),
                child: Center(
                  child: Text(
                    'Juristic Method',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: sixteenPx,
                      fontWeight: FontWeight.w600,
                      color: context.color.titleColor,
                    ),
                  ),
                ),
              ),
              JuristicMethodRadioItem(
                title: 'Hanafi',
                subtitle: 'Late Asr Prayer',
                isSelected:
                    presenter.currentUiState.selectedJuristicMethod == 'Hanafi',
                onTap: () =>
                    presenter.onJuristicMethodChanged(method: 'Hanafi'),
              ),
              JuristicMethodRadioItem(
                title: 'Shafi, Maliki, Hanbali',
                subtitle: 'Earlier Asr Prayer',
                isSelected:
                    presenter.currentUiState.selectedJuristicMethod == 'Shafi',
                onTap: () => presenter.onJuristicMethodChanged(method: 'Shafi'),
              ),
              gapH20,
            ],
          ),
        );
      },
    );
  }
}
