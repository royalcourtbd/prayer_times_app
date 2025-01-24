import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/domain/entities/notification_entity.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';

class NotificationDetailsPage extends StatelessWidget {
  const NotificationDetailsPage({super.key, required this.notification});
  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notification Details',
        theme: Theme.of(context),
      ),
      body: Column(
        children: [
          Text(notification.title),
          Text(notification.description),
        ],
      ),
    );
  }
}
