import 'package:flutter/material.dart';

abstract class NotificationService {
  Future<bool> isNotificationAllowed();

  Future<void> onOpenedFromNotification();

  Future<void> askNotificationPermission({
    required VoidCallback onGrantedOrSkippedForNow,
    required VoidCallback onDenied,
  });
}
