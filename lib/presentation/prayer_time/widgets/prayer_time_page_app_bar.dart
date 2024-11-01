import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/appbar_icon_widget.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({
    super.key,
    required this.theme,
    this.onTapNotification,
  });

  final VoidCallback? onTapNotification;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        decoration: BoxDecoration(
          color: context.color.whiteColor,
          borderRadius: BorderRadius.circular(twentyFourPx),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: twelvePx, vertical: eightPx),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SvgImage(
                SvgPath.icGpsOutline,
              ),
              gapW12,
              Text(
                'Dhaka, Bangladesh',
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: fourteenPx,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        AppbarIconWidget(
          onTapIcon: onTapNotification,
          iconPath: SvgPath.icNotificationOutline,
        ),
        gapW16
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
