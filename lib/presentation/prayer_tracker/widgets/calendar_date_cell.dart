import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CalendarDateCell extends StatelessWidget {
  const CalendarDateCell({
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
                      : isSelected && isWeekend
                          ? context.color.errorColor
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
                color: isSelected && isWeekend
                    ? context.color.errorColor
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
