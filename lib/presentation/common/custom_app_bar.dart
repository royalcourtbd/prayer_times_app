import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/appbar_icon_widget.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar_title.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    required this.theme,
    this.isRoot = false,
    this.actions,
  });
  final String title;
  final ThemeData theme;
  final bool isRoot;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + fivePx,
      leadingWidth: isRoot ? 0 : seventyPx,
      automaticallyImplyLeading: false,
      leading: isRoot
          ? null
          : IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => context.navigatorPop<void>(),
              icon: const AppbarIconWidget(
                iconPath: SvgPath.icBack,
              ),
            ),
      title: CustomAppBarTitle(
        title: title,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + fivePx);
}
