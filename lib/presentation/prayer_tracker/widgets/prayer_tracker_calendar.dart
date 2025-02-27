// lib/presentation/prayer_tracker/widgets/prayer_tracker_calendar.dart

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/circle_icon_widget.dart';
import 'package:intl/intl.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/week_view_calendar.dart';

class PrayerTrackerCalendar extends StatelessWidget {
  const PrayerTrackerCalendar({
    required this.theme,
    required this.selectedDate,
    required this.onDateSelected,
    required this.presenter,
    super.key,
  });

  final ThemeData theme;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final PrayerTrackerPresenter presenter;

  @override
  Widget build(BuildContext context) {
    final HijriCalendar hijri = HijriCalendar.fromDate(selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: twentyPx),
          child: Container(
            padding: padding18,
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
                    onTap: () => presenter.onPreviousDate(),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${hijri.getLongMonthName()}, ${hijri.hYear} H',
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: fourteenPx,
                      ),
                    ),
                    gapH4,
                    Text(
                      DateFormat('MMMM, yyyy').format(selectedDate),
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: context.color.subTitleColor,
                        fontSize: twelvePx,
                      ),
                    ),
                  ],
                ),
                CircleIconWidget(
                  icon: SvgPath.icArrowRight,
                  size: fortyPx,
                  onTap: () => presenter.onNextDate(),
                ),
              ],
            ),
          ),
        ),
        gapH20,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: twentyPx),
          child: WeekViewCalendar(
            theme: theme,
            selectedDate: selectedDate,
            onDateSelected: onDateSelected,
            presenter: presenter,
          ),
        ),
      ],
    );
  }
}
