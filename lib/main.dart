import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/domain/usecases/determine_first_run_use_case.dart';
import 'package:qibla_and_prayer_times/firebase_options.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_times.dart';

Future<void> main() async {
  await _init();
  final bool isFirstRun = await _checkFirstRun();
  runApp(PrayerTimes(isFirstRun: isFirstRun));
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await ServiceLocator.setUp();
}

Future<bool> _checkFirstRun() async {
  final DetermineFirstRunUseCase determineFirstRunUseCase =
      locate<DetermineFirstRunUseCase>();
  return await determineFirstRunUseCase.execute();
}
