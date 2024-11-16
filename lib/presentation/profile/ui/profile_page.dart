import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: theme.textTheme.bodyMedium!.copyWith(
            color: context.color.titleColor,
            fontSize: eighteenPx,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
