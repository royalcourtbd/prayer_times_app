// data/services/notification_service_impl.dart
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:qibla_and_prayer_times/core/external_libs/throttle_service.dart';
import 'package:qibla_and_prayer_times/core/utility/logger_utility.dart';
import 'package:qibla_and_prayer_times/core/utility/trial_utility.dart';
import 'package:qibla_and_prayer_times/core/utility/number_utility.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

import 'package:qibla_and_prayer_times/domain/service/notification_service.dart';

class NotificationServiceImpl implements NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<bool> determineIfNoNeedForPermission() async {
    final bool? noNeedForPermission = await catchAndReturnFuture(() async {
      if (Platform.isIOS) return false;
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt < 28) return true;
      return false;
    });
    return noNeedForPermission ?? false;
  }

  void requestPermission() async {
    NotificationSettings notificationSettings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      carPlay: true,
      announcement: true,
      criticalAlert: true,
      provisional: true,
      providesAppNotificationSettings: true,
    );
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print('Notification permission granted');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('Notification permission provisional');
    } else {
      showMessage(
        message: 'Notification permission denied',
      );
      Future.delayed(2.inSeconds, () {
        AppSettings.openAppSettings(type: AppSettingsType.notification);
      });
    }
  }

  @override
  Future<void> askNotificationPermission({
    required VoidCallback onGrantedOrSkippedForNow,
    required VoidCallback onDenied,
  }) async {
    Throttle.throttle(
      'askNotificationPermissionThrottled',
      1.inSeconds,
      () async {
        await catchFutureOrVoid(() async {
          final bool noNeedForPermission =
              await determineIfNoNeedForPermission();
          if (noNeedForPermission) {
            onGrantedOrSkippedForNow();
            return;
          }

          // Use the requestPermission logic here
          NotificationSettings notificationSettings =
              await _firebaseMessaging.requestPermission(
            alert: true,
            badge: true,
            sound: true,
            carPlay: true,
            announcement: true,
            criticalAlert: true,
            provisional: true,
            providesAppNotificationSettings: true,
          );

          if (notificationSettings.authorizationStatus ==
                  AuthorizationStatus.authorized ||
              notificationSettings.authorizationStatus ==
                  AuthorizationStatus.provisional) {
            onGrantedOrSkippedForNow();
          } else {
            onDenied();
          }
        });
      },
    );
  }

  @override
  Future<void> onOpenedFromNotification() {
    // TODO: implement onOpenedFromNotification
    return Future.value();
  }

  @override
  Future<bool> isNotificationAllowed() async {
    return await catchAndReturnFuture<bool>(() async {
          final NotificationSettings settings =
              await _firebaseMessaging.getNotificationSettings();
          final bool isAllowed =
              settings.authorizationStatus == AuthorizationStatus.authorized;
          logDebug('Notification allowed: $isAllowed');
          return isAllowed;
        }) ??
        false; // Default to false if an error occurs
  }
}
