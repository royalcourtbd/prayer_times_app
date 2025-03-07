import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/menu_drawer_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/main/widgets/drawer_top_widget.dart';

class MenuDrawerBottomSheet extends StatelessWidget {
  MenuDrawerBottomSheet({super.key});

  final MenuDrawerPresenter menuDrawerPresenter = locate<MenuDrawerPresenter>();

  static Future<void> show({required BuildContext context}) async {
    if (!context.mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.transparent,
      builder: (_) => MenuDrawerBottomSheet(),
    );
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
          initialChildSize: 0.65,
          minChildSize: 0.5,
          maxChildSize: 0.88,
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
                          _buildMenuItem(
                            context: context,
                            icon: SvgPath.bkash,
                            title: 'নামাজের সময়সূচী',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: SvgPath.bkash,
                            title: 'ক্যালেন্ডার',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: SvgPath.bkash,
                            title: 'কিবলা',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: SvgPath.bkash,
                            title: 'প্রোফাইল',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: SvgPath.bkash,
                            title: 'সেটিংস',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: SvgPath.bkash,
                            title: 'নোটিফিকেশন',
                            onTap: () {},
                          ),
                          _buildMenuItem(
                            context: context,
                            icon: SvgPath.bkash,
                            title: 'আমাদের সাপোর্ট করুন',
                            onTap: () {},
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
              child: SvgPicture.asset(icon),
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
