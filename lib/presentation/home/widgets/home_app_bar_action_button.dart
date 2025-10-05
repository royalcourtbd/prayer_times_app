import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/external_libs/svg_image.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';

class HomeAppBarActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;

  const HomeAppBarActionButton({
    required this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        padding: padding8,
        width: fortyPx,
        height: fortyPx,
        decoration: BoxDecoration(
          color: context.color.whiteColor,
          borderRadius: BorderRadius.circular(fifteenPx),
        ),
        child: SvgImage(
          icon,
          width: twentyFourPx,
          height: twentyFourPx,
        ),
      ),
    );
  }
}
