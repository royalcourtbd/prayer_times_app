// lib/presentation/prayer_tracker/widgets/prayer_tracker_calendar.dart

import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/calendar_header_widget.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/week_view_calendar.dart';

class EventCalendar extends StatelessWidget {
  const EventCalendar({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CalendarHeaderWidget(
          theme: theme,
          selectedDate: selectedDate,
          onPreviousDate: presenter.onPreviousDate,
          onNextDate: presenter.onNextDate,
          isEventCalendar: true,
          onTap: () {
            print('tapped');
          },
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
