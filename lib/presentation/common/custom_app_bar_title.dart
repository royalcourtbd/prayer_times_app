import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.bodyMedium!.copyWith(
        color: context.color.titleColor,
        fontSize: eighteenPx,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
