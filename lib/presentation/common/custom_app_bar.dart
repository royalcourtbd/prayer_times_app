import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/static/svg_path.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/presentation/common/appbar_icon_widget.dart';
import 'package:salat_times/presentation/common/custom_app_bar_title.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    required this.theme,
    this.isRoot = false,
    this.actions,
    this.backgroundColor,
  });
  final String? title;
  final ThemeData theme;
  final bool isRoot;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      toolbarHeight: kToolbarHeight + fivePx,
      leadingWidth: isRoot ? 0 : seventyPx,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
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
        title: title ?? '',
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + fivePx);
}
