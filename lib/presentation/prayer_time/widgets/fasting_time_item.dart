import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/font_family.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/circle_icon_widget.dart';

class FastingTimeItem extends StatelessWidget {
  final String title;
  final String time;
  final String icon;

  const FastingTimeItem({
    super.key,
    required this.title,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        CircleIconWidget(icon: icon),
        gapW16,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: twelvePx,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.inter,
              ),
            ),
            Text(
              time,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: eighteenPx,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
