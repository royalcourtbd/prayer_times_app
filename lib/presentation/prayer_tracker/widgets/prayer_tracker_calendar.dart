// lib/presentation/prayer_tracker/widgets/prayer_tracker_calendar.dart

import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/circle_icon_widget.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
import 'package:intl/intl.dart';

class PrayerTrackerCalendar extends StatelessWidget {
  const PrayerTrackerCalendar({
    required this.theme,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onPreviousWeek,
    required this.onNextWeek,
    super.key,
  });

  final ThemeData theme;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

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
              CircleIconWidget(
                size: fortyPx,
                icon: SvgPath.icCalenderOutline2,
              ),
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
            onPreviousWeek: onPreviousWeek,
            onNextWeek: onNextWeek,
          ),
        ],
      ),
    );
  }
}

class WeekViewCalendar extends StatelessWidget {
  const WeekViewCalendar({
    required this.theme,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onPreviousWeek,
    required this.onNextWeek,
    super.key,
  });

  final ThemeData theme;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final VoidCallback onPreviousWeek;
  final VoidCallback onNextWeek;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
              .map((day) => Text(
                    day,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: day == 'Fri' || day == 'Sat'
                          ? context.color.errorColor
                          : context.color.titleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: fourteenPx,
                    ),
                  ))
              .toList(),
        ),
        gapH16,
        GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              onPreviousWeek();
            } else if (details.primaryVelocity! < 0) {
              onNextWeek();
            }
          },
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
        child: DateCell(
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

class DateCell extends StatelessWidget {
  const DateCell({
    required this.date,
    required this.hijriDay,
    required this.isSelected,
    required this.isWeekend,
    required this.theme,
    required this.onTap,
    super.key,
  });

  final DateTime date;
  final int hijriDay;
  final bool isSelected;
  final bool isWeekend;
  final ThemeData theme;
  final Function(DateTime) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(date),
      child: Container(
        padding: padding3,
        decoration: BoxDecoration(
          color:
              isSelected ? context.color.primaryColor100 : Colors.transparent,
          borderRadius: radius15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 7.percentWidth,
              decoration: BoxDecoration(
                color: isSelected
                    ? context.color.primaryColor900
                    : Colors.transparent,
                borderRadius: radius15,
              ),
              child: Text(
                hijriDay.toString(),
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: isSelected
                      ? context.color.whiteColor
                      : isWeekend
                          ? context.color.errorColor
                          : context.color.titleColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: fourteenPx,
                ),
              ),
            ),
            gapH4,
            Text(
              date.day.toString(),
              style: theme.textTheme.bodySmall!.copyWith(
                color: isSelected
                    ? context.color.primaryColor900
                    : isWeekend
                        ? context.color.errorColor
                        : context.color.primaryColor400,
                fontSize: twelvePx,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
