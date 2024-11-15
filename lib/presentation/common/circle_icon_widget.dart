import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CircleIconWidget extends StatelessWidget {
  const CircleIconWidget({
    super.key,
    required this.icon,
    this.height,
    this.width,
    this.onTap,
    this.iconColor,
  });

  final String icon;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding10,
        width: width ?? fiftyPx,
        height: height ?? fiftyPx,
        decoration: BoxDecoration(
          color: context.color.primaryColor25,
          shape: BoxShape.circle,
        ),
        child: SvgImage(
          icon,
          color: iconColor ?? context.color.primaryColor900,
        ),
      ),
    );
  }
}
