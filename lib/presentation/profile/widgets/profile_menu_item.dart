import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/circle_icon_widget.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    required this.icon,
    required this.title,
    this.onTap,
    super.key,
  });

  final String icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleIconWidget(
            icon: icon,
            iconColor: context.color.blackColor900,
            size: fortyPx,
          ),
          gapW15,
          Text(
            title,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: sixteenPx,
            ),
          ),
        ],
      ),
    );
  }
}
