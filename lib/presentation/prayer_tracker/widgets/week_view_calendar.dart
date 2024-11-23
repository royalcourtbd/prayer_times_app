import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/calendar_date_cell.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/day_name_list.dart';

class WeekViewCalendar extends StatelessWidget {
  const WeekViewCalendar({
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
      children: [
        DayNameList(theme: theme),
        gapH16,
        GestureDetector(
          onHorizontalDragEnd: (details) => presenter.handleSwipe(details),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildWeekDays(context),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildWeekDays(BuildContext context) {
    final DateTime firstDayOfWeek = selectedDate.subtract(
      Duration(days: selectedDate.weekday % 7),
    );

    return List.generate(7, (index) {
      final DateTime date = firstDayOfWeek.add(Duration(days: index));
      final HijriCalendar hijri = HijriCalendar.fromDate(date);
      final bool isSelected =
          date.day == selectedDate.day && date.month == selectedDate.month;
      final bool isWeekend = date.weekday == 5 || date.weekday == 6;

      return Expanded(
        child: CalendarDateCell(
          date: date,
          hijriDay: hijri.hDay,
          isSelected: isSelected,
          isWeekend: isWeekend,
          theme: theme,
          onTap: onDateSelected,
        ),
      );
    });
  }
}
