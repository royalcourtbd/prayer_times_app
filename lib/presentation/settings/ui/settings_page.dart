import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
import 'package:qibla_and_prayer_times/presentation/profile/widgets/profile_menu_item.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/settings/widgets/juristic_method_bottom_sheet.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final SettingsPagePresenter _presenter = locate<SettingsPagePresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PresentableWidgetBuilder(
        presenter: _presenter,
        onInit: () => _presenter.onInit(),
        builder: () {
          _presenter.updateContext(context);
          final SettingsPageUiState currentUiState = _presenter.currentUiState;
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Settings',
              theme: theme,
            ),
            body: Padding(
              padding: padding15,
              child: CustomCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ProfileMenuItem(
                      icon: SvgPath.icLocation,
                      title: 'Set Location',
                      subtitle: 'Dhaka, Bangladesh',
                    ),
                    gapH20,
                    ProfileMenuItem(
                      icon: SvgPath.icClock,
                      title: 'Juristic Method',
                      subtitle: currentUiState.selectedJuristicMethod,
                      onTap: () => JuristicMethodBottomSheet.show(
                        context: context,
                        presenter: _presenter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
