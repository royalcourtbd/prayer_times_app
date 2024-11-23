// lib/presentation/prayer_tracker/widgets/prayer_tracker_calendar.dart

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
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

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${hijri.getLongMonthName()}, ${hijri.hYear} H',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: context.color.titleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: eighteenPx,
                    ),
                  ),
                  gapH4,
                  Text(
                    DateFormat('MMMM, yyyy').format(selectedDate),
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: context.color.titleColor,
                      fontSize: fourteenPx,
                    ),
                  ),
                ],
              ),
              // TODO: Add this feature later
              // CircleIconWidget(
              //   size: fortyPx,
              //   icon: SvgPath.icCalenderOutline2,
              // ),
            ],
          ),
          Divider(
            color: context.color.primaryColor100,
            height: thirtyTwoPx,
          ),
          // gapH16,
          WeekViewCalendar(
            theme: theme,
            selectedDate: selectedDate,
            onDateSelected: onDateSelected,
            presenter: presenter,
          ),
        ],
      ),
    );
  }
}
