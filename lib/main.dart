import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/data/services/database/database_loader.dart';
import 'package:qibla_and_prayer_times/domain/usecases/determine_first_run_use_case.dart';

import 'package:qibla_and_prayer_times/presentation/prayer_times.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await _initializeApp();
      runApp(PrayerTimes(isFirstRun: await _checkFirstRun()));
    },
    (error, stackTrace) => (error, stackTrace, fatal: true),
  );
}

Future<void> _initializeApp() async {
  await loadEnv();
  await ServiceLocator.setUp();
}

Future<bool> _checkFirstRun() {
  return locate<DetermineFirstRunUseCase>().execute();
}
