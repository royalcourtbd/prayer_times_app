import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/di/service_locator.dart';
import 'package:prayer_times/core/static/svg_path.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/presentation/common/custom_app_bar.dart';
import 'package:prayer_times/presentation/common/settings_grid_item.dart';
import 'package:prayer_times/presentation/settings/presenter/settings_page_presenter.dart';
import 'package:prayer_times/presentation/settings/widgets/juristic_method_bottom_sheet.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final SettingsPagePresenter _presenter = locate<SettingsPagePresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        theme: theme,
        isRoot: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: twentyPx),
        child: Column(
          children: [
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.6,
                crossAxisSpacing: twelvePx,
                mainAxisSpacing: twelvePx,
              ),
              children: [
                SettingsGridItem(
                  icon: SvgPath.icLocation,
                  title: 'Set Your Location',
                  onTap: () =>
                      _presenter.showSelectLocationBottomSheet(context),
                ),
                SettingsGridItem(
                  icon: SvgPath.icLocation,
                  title: 'Prayer Settings',
                  onTap: () => showMessage(
                    message: 'Prayer Settings Page Under Construction',
                  ),
                ),
                SettingsGridItem(
                  icon: SvgPath.icLocation,
                  title: 'Calculation Method',
                  onTap: () => showMessage(
                    message: 'Calculation Method Page Under Construction',
                  ),
                ),
                SettingsGridItem(
                  icon: SvgPath.icLocation,
                  title: 'Time Adjustment',
                  onTap: () => showMessage(
                    message: 'Time Adjustment Page Under Construction',
                  ),
                ),
                SettingsGridItem(
                  icon: SvgPath.icShare,
                  title: 'Juristic Method',
                  onTap: () => JuristicMethodBottomSheet.show(
                    context: context,
                    presenter: _presenter,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
