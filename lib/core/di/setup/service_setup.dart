import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:qibla_and_prayer_times/core/di/setup/setup_module.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:qibla_and_prayer_times/data/services/backend_as_a_service.dart';
import 'package:qibla_and_prayer_times/data/services/database/prayer_database.dart';
import 'package:qibla_and_prayer_times/data/services/error_message_handler_impl.dart';
import 'package:qibla_and_prayer_times/data/services/local_cache_service.dart';
import 'package:qibla_and_prayer_times/data/services/location_service.dart';
import 'package:qibla_and_prayer_times/data/services/waqt_calculation_service_impl.dart';

import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';
import 'package:qibla_and_prayer_times/domain/service/time_service.dart';
import 'package:qibla_and_prayer_times/domain/service/waqt_calculation_service.dart';

class ServiceSetup implements SetupModule {
  final GetIt _serviceLocator;
  ServiceSetup(this._serviceLocator);

  @override
  Future<void> setup() async {
    log('init service setup');
    _serviceLocator
      ..registerLazySingleton<ErrorMessageHandler>(
          () => ErrorMessageHandlerImpl())
      ..registerLazySingleton<WaqtCalculationService>(
          () => WaqtCalculationServiceImpl())
      ..registerLazySingleton(() => TimeService())
      ..registerLazySingleton(() => BackendAsAService())
      ..registerLazySingleton(() => PrayerDatabase())
      ..registerLazySingleton(() => LocationService())
      ..registerLazySingleton(() => InAppReview.instance)
      ..registerLazySingleton(() => LocalCacheService());
    await LocalCacheService.setUp();
    await _setUpFirebaseServices();
    await _setUpAudioService();
  }

  Future<void> _setUpFirebaseServices() async {
    // Firebase সার্ভিস সেটআপ লজিক
  }

  Future<void> _setUpAudioService() async {
    // অডিও সার্ভিস সেটআপ লজিক
  }
}
