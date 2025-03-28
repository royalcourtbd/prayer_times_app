import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/data/services/database/database_loader.dart';
import 'package:qibla_and_prayer_times/domain/usecases/determine_first_run_use_case.dart';
import 'package:qibla_and_prayer_times/domain/usecases/register_device_usecase.dart';

import 'package:qibla_and_prayer_times/presentation/prayer_times.dart';

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
  // সার্ভিস লোকেটর থেকে ইউজকেসটি পান
  final registerDeviceUsecase = locate<RegisterDeviceUsecase>();

  // ইউজকেস এক্সিকিউট করুন
  final result = await registerDeviceUsecase.execute();

  // রেজাল্ট হ্যান্ডেল করুন (অপশনাল)
  result.fold(
    (error) => debugPrint('ডিভাইস রেজিস্ট্রেশন ব্যর্থ: $error'),
    (_) => debugPrint('ডিভাইস সফলভাবে রেজিস্টার করা হয়েছে'),
  );
}
