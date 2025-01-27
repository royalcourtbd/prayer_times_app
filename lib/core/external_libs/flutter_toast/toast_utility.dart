// toast_utility.dart
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_times.dart';
import 'custom_toast.dart';
import 'debouncer.dart';

class ToastUtility {
  static final Debouncer _debouncer = Debouncer(milliseconds: 1300);

  static void showCustomToast({
    BuildContext? context,
    required String message,
    Duration duration = const Duration(seconds: 2),
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double fontSize = 16.0,
    double xOffset = 0.0,
    double yOffset = 50.0,
  }) {
    final BuildContext finalContext = context ?? PrayerTimes.globalContext;

    if (!finalContext.mounted) return;

    final OverlayState? overlay = Overlay.maybeOf(finalContext);
    if (overlay == null) return;

    _debouncer.run(
      () {
        final OverlayEntry overlayEntry = OverlayEntry(
          builder: (context) => CustomToast(
            message: message,
            duration: duration,
            xOffset: xOffset,
            yOffset: yOffset,
          ),
        );

        overlay.insert(overlayEntry);

        Future.delayed(
          duration + const Duration(milliseconds: 300),
          () {
            overlayEntry.remove();
          },
        );
      },
    );
  }

  static void dispose() {
    _debouncer.dispose();
  }
}
