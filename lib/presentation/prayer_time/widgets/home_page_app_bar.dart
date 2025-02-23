import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/home_app_bar_action_button.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({
    super.key,
    this.onTapCategory,
    this.onTapFetchLocation,
    required this.theme,
  });

  final VoidCallback? onTapCategory;
  final VoidCallback? onTapFetchLocation;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HomeAppBarActionButton(
            icon: SvgPath.icCategoryFill,
            onTap: onTapCategory,
          ),
          Image.asset(
            SvgPath.imgAppName,
            width: 40.percentWidth,
          ),
          HomeAppBarActionButton(
            icon: SvgPath.icGpsOutline,
            onTap: onTapFetchLocation,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
