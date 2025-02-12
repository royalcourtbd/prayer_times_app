// toast_utility.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_toast.dart';
import 'debouncer.dart';

class ToastUtility {
  static final Debouncer _debouncer = Debouncer(milliseconds: 1300);

  static void showCustomToast({
    required String message,
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double fontSize = 16.0,
    double xOffset = 0.0,
    double yOffset = 50.0,
  }) {
    _debouncer.run(() {
      Get.showOverlay(
        opacity: 0,
        loadingWidget: CustomToast(
          message: message,
          duration: duration,
          xOffset: xOffset,
          yOffset: yOffset,
        ),
        asyncFunction: () async {
          await Future.delayed(duration + const Duration(milliseconds: 300));
        },
      );
    });
  }

  static void dispose() {
    _debouncer.dispose();
  }
}
