import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/static/svg_path.dart';
import 'package:prayer_times/presentation/home/presenter/home_presenter.dart';
import 'package:prayer_times/presentation/home/widgets/home_app_bar_action_button.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({
    super.key,
    this.onTapCategory,
    this.onTapFetchLocation,
    required this.theme,
    required this.presenter,
  });

  final VoidCallback? onTapCategory;
  final VoidCallback? onTapFetchLocation;
  final ThemeData theme;
  final HomePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      elevation: 0,
      centerTitle: true,
      toolbarHeight: kToolbarHeight + eightPx,
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
            width: 35.percentWidth,
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight + eightPx);
}
