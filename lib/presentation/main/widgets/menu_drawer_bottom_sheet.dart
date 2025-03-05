import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/main/widgets/drawer_top_widget.dart';

class MenuDrawerBottomSheet extends StatelessWidget {
  const MenuDrawerBottomSheet({super.key});

  static Future<void> show({required BuildContext context}) async {
    final MenuDrawerBottomSheet menuDrawerBottomSheet = MenuDrawerBottomSheet();

    if (!context.mounted) return;

    await context.showBottomSheet(menuDrawerBottomSheet, context);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Stack(
      children: [
        ModalBarrier(
          color: Colors.transparent,
          dismissible: true,
          onDismiss: () => context.navigatorPop(),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(twentyPx)),
              ),
              child: Column(
                children: [
                  DrawerTopWidget(theme: theme),
                  Expanded(
                      child: ListView(
                    children: [
                      _buildMenuItem(
                          context: context,
                          icon: SvgPath.bkash,
                          title: ' wehfegw',
                          onTap: () {}),
                      _buildMenuItem(
                          context: context,
                          icon: SvgPath.bkash,
                          title: ' wehfegw',
                          onTap: () {}),
                      _buildMenuItem(
                          context: context,
                          icon: SvgPath.bkash,
                          title: ' wehfegw',
                          onTap: () {}),
                      _buildMenuItem(
                          context: context,
                          icon: SvgPath.bkash,
                          title: ' wehfegw',
                          onTap: () {}),
                      _buildMenuItem(
                          context: context,
                          icon: SvgPath.bkash,
                          title: ' wehfegw',
                          onTap: () {}),
                      _buildMenuItem(
                          context: context,
                          icon: SvgPath.bkash,
                          title: ' wehfegw',
                          onTap: () {}),
                      _buildMenuItem(
                          context: context,
                          icon: SvgPath.bkash,
                          title: ' wehfegw',
                          onTap: () {}),
                    ],
                  ))
                ],
              ),
            );
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
