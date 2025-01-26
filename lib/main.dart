import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/domain/usecases/determine_first_run_use_case.dart';
import 'package:qibla_and_prayer_times/firebase_options.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_times.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await _initializeApp();
      runApp(PrayerTimes(isFirstRun: await _checkFirstRun()));
    },
    (error, stackTrace) => _reportError(error, stackTrace, fatal: true),
  );
}

Future<void> _initializeApp() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _setupErrorHandling();
    await ServiceLocator.setUp();
  } catch (error, stackTrace) {
    _reportError(error, stackTrace);
    rethrow;
  }
}

void _setupErrorHandling() {
  FlutterError.onError = (details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    return true;
  };
}

Future<bool> _checkFirstRun() {
  return locate<DetermineFirstRunUseCase>().execute();
}

Future<void> _reportError(
  dynamic error,
  StackTrace stackTrace, {
  bool fatal = false,
}) async {
  print('Error: $error, StackTrace: $stackTrace');

  if (Firebase.apps.isNotEmpty) {
    if (fatal) {
      await FirebaseCrashlytics.instance
          .recordError(error, stackTrace, fatal: true);
    } else {
      await FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }
}
