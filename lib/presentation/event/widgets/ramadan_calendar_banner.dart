import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/event/widgets/calendar_action_button.dart';

class RamadanCalendarBanner extends StatelessWidget {
  const RamadanCalendarBanner({
    required this.theme,
    required this.onCalendarTap,
    super.key,
  });

  final ThemeData theme;
  final VoidCallback onCalendarTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: twentyPx),
      child: Container(
        height: 55.percentWidth,
        width: 100.percentWidth,
        padding: padding15,
        decoration: BoxDecoration(
          borderRadius: radius20,
          image: DecorationImage(
            image: AssetImage(SvgPath.bgEvent),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(context),
            gapH6,
            _buildSubtitle(context),
            gapH30,
            CalendarActionButton(
              onTap: onCalendarTap,
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Ramadan Calendar 2025',
      style: theme.textTheme.bodyMedium!.copyWith(
        fontSize: twentyTwoPx,
        fontWeight: FontWeight.bold,
        color: context.color.whiteColor,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      'Ramadan Time Schedule in Dhaka',
      style: theme.textTheme.bodyMedium!.copyWith(
        fontSize: thirteenPx,
        color: context.color.whiteColor.withOpacityInt(0.6),
      ),
    );
  }
}
