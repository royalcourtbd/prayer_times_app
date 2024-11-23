import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';

class CountdownProgressBar extends StatelessWidget {
  const CountdownProgressBar({
    super.key,
    required this.theme,
    this.remainingTime,
    this.progress,
    this.title,
    this.activeWaqtType,
  });

  final ThemeData theme;
  final String? remainingTime;
  final String? title;
  final double? progress;
  final WaqtType? activeWaqtType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Remaining ${title ?? ''}  ',
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: context.color.titleColor,
                  fontSize: twelvePx,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: remainingTime,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: context.color.primaryColor600,
                  fontSize: twelvePx,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        gapH10,
        Stack(
          children: [
            Container(
              height: ninePx,
              width: double.infinity,
              decoration: BoxDecoration(
                color: activeWaqtType == WaqtType.sunrise
                    ? context.color.errorColor100
                    : context.color.primaryColor25,
                borderRadius: radius10,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500), // Smooth animation
              height: ninePx,
              width: MediaQuery.sizeOf(context).width *
                  ((100 - progress!) / 100), // Reverse progress
              decoration: BoxDecoration(
                color: _getProgressBarColor(context),
                borderRadius: radius10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getProgressBarColor(BuildContext context) {
    if (activeWaqtType == WaqtType.sunrise) {
      return context.color.errorColor;
    }
    return context.color.primaryColor900;
  }
}
