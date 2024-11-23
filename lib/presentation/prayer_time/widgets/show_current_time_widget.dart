import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class ShowCurrentTimeWidget extends StatelessWidget {
  const ShowCurrentTimeWidget({
    required this.currentTime,
    required this.theme,
    super.key,
  });

  final String currentTime;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final List<String> timeParts = currentTime.split(' ');
    final String time = timeParts[0];
    final String meridiem = timeParts[1]; // AM/PM part

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 36.percentWidth),
          child: Text(
            time,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: context.color.titleColor,
              fontSize: thirtyNinePx,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          top: twentyTwoPx,
          right: -twentyFivePx,
          child: Text(
            meridiem,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: context.color.titleColor,
              fontSize: sixteenPx,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
