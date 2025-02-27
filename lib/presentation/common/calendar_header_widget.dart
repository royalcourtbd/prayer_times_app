import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/circle_icon_widget.dart';

class CalendarHeaderWidget extends StatelessWidget {
  const CalendarHeaderWidget({
    required this.theme,
    required this.selectedDate,
    required this.onPreviousDate,
    required this.onNextDate,
    this.onTap,
    super.key,
  });

  final ThemeData theme;
  final DateTime selectedDate;
  final VoidCallback onPreviousDate;
  final VoidCallback onNextDate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final HijriCalendar hijri = HijriCalendar.fromDate(selectedDate);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: twentyPx),
      child: GestureDetector(
        onTap: onTap,
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
                  onTap: onPreviousDate,
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
                onTap: onNextDate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
