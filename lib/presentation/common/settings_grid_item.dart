import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/presentation/common/circle_icon_widget.dart';

class SettingsGridItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;

  const SettingsGridItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: sixteenPx,
          vertical: fourteenPx,
        ),
        decoration: BoxDecoration(
          color:
              backgroundColor ?? context.color.primaryColor.withOpacityInt(.05),
          borderRadius: radius12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleIconWidget(
              icon: icon,
              size: fortyPx,
            ),
            Text(
              title,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: thirteenPx,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
