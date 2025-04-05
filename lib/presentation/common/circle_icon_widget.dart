import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/external_libs/svg_image.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/utility/utility.dart';

class CircleIconWidget extends StatelessWidget {
  const CircleIconWidget({
    super.key,
    required this.icon,
    this.size,
    this.onTap,
    this.iconColor,
  });

  final String icon;
  final double? size;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final double containerSize = size ?? fiftyPx;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding10,
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: context.color.primaryColor.withOpacityInt(0.1),
          shape: BoxShape.circle,
        ),
        child: SvgImage(
          icon,
          color: iconColor ?? context.color.primaryColor,
        ),
      ),
    );
  }
}
