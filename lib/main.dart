import 'dart:async';
import 'package:flutter/material.dart';
import 'package:salat_times/core/di/service_locator.dart';
import 'package:salat_times/data/services/database/database_loader.dart';
import 'package:salat_times/domain/usecases/determine_first_run_use_case.dart';
import 'package:salat_times/domain/usecases/register_device_usecase.dart';
import 'package:salat_times/presentation/prayer_times.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await _initializeApp();
      runApp(PrayerTimes(isFirstRun: await _checkFirstRun()));
      _registerDevice();
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

Future<void> _registerDevice() async {
  final registerDeviceUsecase = locate<RegisterDeviceUsecase>();

  final result = await registerDeviceUsecase.execute();

  result.fold(
    (error) => debugPrint('Failed to register device: $error'),
    (_) => debugPrint('Device registered successfully'),
  );
}
