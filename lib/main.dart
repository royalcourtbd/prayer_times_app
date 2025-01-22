import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/domain/usecases/determine_first_run_use_case.dart';
import 'package:qibla_and_prayer_times/presentation/common/widgets/error_widget.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_times.dart';

Future<void> main() async {
  await _init();
  final bool isFirstRun = await _checkFirstRun();
  runApp(PrayerTimes(isFirstRun: isFirstRun));
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Add this to filter out Mesa logs
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message?.contains('exportSyncFdForQSRILocked') == false) return;
  };
  await ServiceLocator.setUp();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    runApp(ErrorWidgetClass(errorDetails: details));
  };
}

Future<bool> _checkFirstRun() async {
  final DetermineFirstRunUseCase determineFirstRunUseCase =
      locate<DetermineFirstRunUseCase>();
  return await determineFirstRunUseCase.execute();
}
