import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_switch.dart';

class NotificationPermissionSection extends StatelessWidget {
  final ThemeData theme;
  final bool notifyMe;
  final Function(bool) onChanged;

  const NotificationPermissionSection({
    super.key,
    required this.theme,
    required this.notifyMe,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notify Me',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: context.color.titleColor,
                fontSize: fourteenPx,
                fontWeight: FontWeight.w600,
              ),
            ),
            gapH2,
            Text(
              'Notify me every prayer time',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: context.color.subTitleColor,
                fontSize: twelvePx,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        CustomSwitch(
          value: notifyMe,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
