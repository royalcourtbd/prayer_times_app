import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class AppbarIconWidget extends StatelessWidget {
  const AppbarIconWidget({
    super.key,
    this.onTapIcon,
    this.iconPath,
  });

  final VoidCallback? onTapIcon;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapIcon,
      child: Container(
        decoration: BoxDecoration(
          color: context.color.whiteColor,
          borderRadius: BorderRadius.circular(twentyFourPx),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: twelvePx, vertical: eightPx),
          child: SvgImage(
            iconPath ?? SvgPath.icNotificationOutline,
          ),
        ),
      ),
    );
  }
}
