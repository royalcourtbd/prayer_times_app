import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_modal_sheet.dart';
import 'package:qibla_and_prayer_times/presentation/main/widgets/drawer_top_widget.dart';

class MenuDrawerBottomSheet extends StatelessWidget {
  const MenuDrawerBottomSheet({super.key});

  static Future<void> show({required BuildContext context}) async {
    final MenuDrawerBottomSheet menuDrawerBottomSheet = MenuDrawerBottomSheet();

    if (context.mounted) {
      await context.showBottomSheet(menuDrawerBottomSheet, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CustomModalSheet(
      theme: theme,
      // bottomSheetTitle: 'Menus',
      children: [
        DrawerTopWidget(theme: theme),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icNotificationOutline,
          title: 'Notification',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icNotificationOutline,
          title: 'Notification',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icNotificationOutline,
          title: 'Notification',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icNotificationOutline,
          title: 'Notification',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icNotificationOutline,
          title: 'Notification',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icNotificationOutline,
          title: 'Notification',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icNotificationOutline,
          title: 'Notification',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icNotificationOutline,
          title: 'Notification',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icGlobalSearch,
          title: 'About Us',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icLovely,
          title: 'Support Us',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icChart,
          title: 'Report Us',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icUserProfile,
          title: 'Privacy Policy',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icShare,
          title: 'Share This App',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icCrown,
          title: 'Rate this App',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
        _buildMenuItem(
          context: context,
          icon: SvgPath.icCheckMark,
          title: 'Thanks & Credit',
          onTap: () {
            context.navigatorPop();
            showMessage(message: 'Coming soon');
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: tenPx),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(tenPx),
              decoration: BoxDecoration(
                color: context.color.primaryColor.withOpacityInt(0.1),
                borderRadius: BorderRadius.circular(tenPx),
              ),
              child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  context.color.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            gapW15,
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: fourteenPx,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
