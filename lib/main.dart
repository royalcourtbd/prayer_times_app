import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_times.dart';

void main() async {
  await _init();
  runApp(const PrayerTimes());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.setUp();
}
