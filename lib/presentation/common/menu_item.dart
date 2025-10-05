import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/static/font_family.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/presentation/common/circle_icon_widget.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    super.key,
  });

  final String icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleIconWidget(
            icon: icon,
            iconColor: context.color.blackColor900,
            size: fortyPx,
          ),
          gapW15,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: sixteenPx,
                ),
              ),
              if (subtitle != null) ...[
                gapH2,
                Text(
                  subtitle ?? '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: fourteenPx,
                    fontFamily: FontFamily.inter,
                    color: context.color.subTitleColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
