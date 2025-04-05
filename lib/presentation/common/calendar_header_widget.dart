import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:prayer_times/core/static/svg_path.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/presentation/common/circle_icon_widget.dart';

class CalendarHeaderWidget extends StatelessWidget {
  const CalendarHeaderWidget({
    required this.theme,
    required this.selectedDate,
    required this.onPreviousDate,
    required this.onNextDate,
    this.onTap,
    this.isEventCalendar = false,
    super.key,
  });

  final ThemeData theme;
  final DateTime selectedDate;
  final VoidCallback onPreviousDate;
  final VoidCallback onNextDate;
  final VoidCallback? onTap;
  final bool isEventCalendar;

  @override
  Widget build(BuildContext context) {
    final HijriCalendar hijri = HijriCalendar.fromDate(selectedDate);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: fourteenPx, vertical: eighteenPx),
        decoration: BoxDecoration(
          color: context.color.primaryColor.withOpacityInt(0.05),
          borderRadius: radius20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: CircleIconWidget(
                icon: SvgPath.icArrowRight,
                size: fortyPx,
                onTap: onPreviousDate,
              ),
            ),
            isEventCalendar
                ? _buildEventCalendarDateShowWidget(hijri, context)
                : _buildPrayerTrackerDateShowWidget(context, hijri),
            CircleIconWidget(
              icon: SvgPath.icArrowRight,
              size: fortyPx,
              onTap: onNextDate,
            ),
          ],
        ),
      ),
    );
  }

  Column _buildPrayerTrackerDateShowWidget(
      BuildContext context, HijriCalendar hijri) {
    return Column(
      children: [
        Text(
          getFormattedDate(selectedDate),
          style: theme.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: fourteenPx,
          ),
        ),
        gapH4,
        Text(
          'Tracking Today',
          style: theme.textTheme.bodyMedium!.copyWith(
            color: context.color.subTitleColor,
            fontSize: twelvePx,
          ),
        ),
      ],
    );
  }

  Column _buildEventCalendarDateShowWidget(
      HijriCalendar hijri, BuildContext context) {
    return Column(
      children: [
        Text(
          '${hijri.getLongMonthName()} ${hijri.hDay}, ${hijri.hYear} H',
          style: theme.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: fourteenPx,
          ),
        ),
        gapH4,
        Text(
          getFormattedDate(selectedDate),
          style: theme.textTheme.bodyMedium!.copyWith(
            color: context.color.subTitleColor,
            fontSize: twelvePx,
          ),
        ),
      ],
    );
  }
}
