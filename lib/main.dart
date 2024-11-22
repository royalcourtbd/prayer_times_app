import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/presentation/common/widgets/error_widget.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_times.dart';

Future<void> main() async {
  await _init();
  runApp(const PrayerTimes());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.setUp();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    runApp(ErrorWidgetClass(errorDetails: details));
  };
}
