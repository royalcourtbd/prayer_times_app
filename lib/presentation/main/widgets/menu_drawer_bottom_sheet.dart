import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/settings_grid_item.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/menu_drawer_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/main/widgets/drawer_top_widget.dart';
import 'package:qibla_and_prayer_times/presentation/notification/ui/notification_page.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/support_us/ui/support_us_page.dart';

class MenuDrawerBottomSheet extends StatelessWidget {
  MenuDrawerBottomSheet({super.key});

  final MenuDrawerPresenter menuDrawerPresenter = locate<MenuDrawerPresenter>();
  late final SettingsPagePresenter _settingsPagePresenter =
      locate<SettingsPagePresenter>();

  static Future<void> show({required BuildContext context}) async {
    final MenuDrawerBottomSheet menuDrawerBottomsheet = MenuDrawerBottomSheet();
    if (!context.mounted) return;
    context.showBottomSheet(menuDrawerBottomsheet, context);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      children: [
        ModalBarrier(
          color: Colors.transparent,
          dismissible: true,
          onDismiss: () => Navigator.of(context).pop(),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(twentyPx)),
              ),
              child: Column(
                children: [
                  DrawerTopWidget(theme: theme),
                  gapH10,
                  Expanded(
                    child: Padding(
                      padding: paddingH20,
                      child: ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        children: [
                          Container(
                            padding: padding8,
                            decoration: BoxDecoration(
                              color: context.color.primaryColor50,
                              borderRadius: radius6,
                            ),
                            child: Text(
                              'Menus',
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: context.color.btnText,
                                fontWeight: FontWeight.w600,
                                fontSize: thirteenPx,
                              ),
                            ),
                          ),
                          gapH10,
                          GridView(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 1.6,
                            ),
                            children: [
                              SettingsGridItem(
                                icon: SvgPath.icNotificationFill,
                                title: 'Notification',
                                onTap: () =>
                                    context.navigatorPush(NotificationPage()),
                              ),
                              SettingsGridItem(
                                icon: SvgPath.icInformation,
                                title: 'Aboute',
                                onTap: () => showMessage(
                                  message: 'Under Construction',
                                ),
                              ),
                              SettingsGridItem(
                                icon: SvgPath.icLovelyFill,
                                title: 'Support Us',
                                onTap: () =>
                                    context.navigatorPush(SupportUsPage()),
                              ),
                              SettingsGridItem(
                                icon: SvgPath.icSmsEdit,
                                title: 'Report Us',
                                onTap: () => showMessage(
                                  message: 'Under Construction',
                                ),
                              ),
                              SettingsGridItem(
                                icon: SvgPath.icSecuritySafe,
                                title: 'Privacy Policy',
                                onTap: () => showMessage(
                                  message: 'Under Construction',
                                ),
                              ),
                              SettingsGridItem(
                                icon: SvgPath.icShare,
                                title: 'Share This App',
                                onTap: _settingsPagePresenter.onShareAppTap,
                              ),
                              SettingsGridItem(
                                icon: SvgPath.icLike,
                                title: 'Thanks & Credit',
                                onTap: () => showMessage(
                                  message: 'Under Construction',
                                ),
                              ),
                              SettingsGridItem(
                                icon: SvgPath.icStar,
                                title: 'Rate this App',
                                onTap: _settingsPagePresenter.onRatingClicked,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
