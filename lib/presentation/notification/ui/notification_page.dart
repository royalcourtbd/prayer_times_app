import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notification',
        theme: theme,
      ),
    );
  }
}
