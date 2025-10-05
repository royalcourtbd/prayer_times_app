import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:salat_times/core/di/setup/setup_module.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:salat_times/core/utility/trial_utility.dart';
import 'package:salat_times/data/services/backend_as_a_service.dart';
import 'package:salat_times/data/services/database/prayer_database.dart';
import 'package:salat_times/data/services/error_message_handler_impl.dart';
import 'package:salat_times/data/services/get_server_key.dart';
import 'package:salat_times/data/services/local_cache_service.dart';
import 'package:salat_times/data/services/location_service.dart';
import 'package:salat_times/data/services/notification/notification_service_impl.dart';
import 'package:salat_times/data/services/waqt_calculation_service_impl.dart';
import 'package:salat_times/domain/service/error_message_handler.dart';
import 'package:salat_times/domain/service/notification_service.dart';
import 'package:salat_times/domain/service/time_service.dart';
import 'package:salat_times/domain/service/waqt_calculation_service.dart';
import 'package:salat_times/firebase_options.dart';

class ServiceSetup implements SetupModule {
  final GetIt _serviceLocator;
  ServiceSetup(this._serviceLocator);

  @override
  Future<void> setup() async {
    await _setUpFirebaseServices();
    _serviceLocator
      ..registerLazySingleton<ErrorMessageHandler>(ErrorMessageHandlerImpl.new)
      ..registerLazySingleton<NotificationService>(NotificationServiceImpl.new)
      ..registerLazySingleton<WaqtCalculationService>(
          () => WaqtCalculationServiceImpl())
      ..registerLazySingleton(() => TimeService())
      ..registerLazySingleton(BackendAsAService.new)
      ..registerLazySingleton(() => PrayerDatabase())
      ..registerLazySingleton(() => LocationService())
      ..registerLazySingleton(() => InAppReview.instance)
      ..registerLazySingleton(() => GetServerKey())
      ..registerLazySingleton(LocalCacheService.new);
    await GetServerKey().getServerKeyToken();
    await LocalCacheService.setUp();

    await _setUpAudioService();
  }

  Future<void> _setUpFirebaseServices() async {
    await catchFutureOrVoid(
      () async {
        final FirebaseApp? firebaseApp = await catchAndReturnFuture(() async {
          return Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        });

        if (firebaseApp == null) return;
        if (kDebugMode) return;

        FlutterError.onError =
            FirebaseCrashlytics.instance.recordFlutterFatalError;
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(
            error,
            stack,
            fatal: true,
            printDetails: false,
          );
          return true;
        };
      },
    );
  }

  Future<void> _setUpAudioService() async {
    // অডিও সার্ভিস সেটআপ লজিক
  }
}
