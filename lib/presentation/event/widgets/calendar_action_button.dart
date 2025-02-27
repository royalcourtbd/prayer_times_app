import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CalendarActionButton extends StatelessWidget {
  const CalendarActionButton({
    required this.onTap,
    required this.theme,
    super.key,
  });

  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(maxWidth: 55.percentWidth),
        padding: EdgeInsets.symmetric(
          horizontal: fourteenPx,
          vertical: twelvePx,
        ),
        decoration: BoxDecoration(
          color: context.color.whiteColor,
          borderRadius: radius12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'See Full Calendar',
              semanticsLabel: 'View complete Ramadan calendar',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: thirteenPx,
                color: context.color.primaryColor,
              ),
            ),
            gapW10,
            Icon(
              Icons.arrow_forward_outlined,
              size: twentyPx,
              color: context.color.primaryColor,
              semanticLabel: 'Forward arrow',
            ),
          ],
        ),
      ),
    );
  }
}
