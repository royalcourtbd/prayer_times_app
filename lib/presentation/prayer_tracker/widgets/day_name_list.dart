import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/utility/utility.dart';

class DayNameList extends StatelessWidget {
  const DayNameList({
    required this.theme,
    super.key,
  });

  final ThemeData theme;

  static const List<String> _dayNames = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: twentyPx,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _dayNames.length,
          (index) {
            final String day = _dayNames[index];
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: day == 'Fri' || day == 'Sat'
                        ? context.color.errorColor
                        : context.color.titleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: fourteenPx,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
