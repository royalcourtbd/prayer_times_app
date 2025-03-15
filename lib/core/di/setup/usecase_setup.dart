import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/di/setup/setup_module.dart';
import 'package:qibla_and_prayer_times/domain/usecases/determine_first_run_use_case.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_active_waqt_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_countries_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_juristic_method_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_location_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_notifications_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_tracker_data_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_all_prayer_tracker_data_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_remaining_time_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/save_first_time_use_case.dart';
import 'package:qibla_and_prayer_times/domain/usecases/save_prayer_tracker_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/search_countries_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/update_juristic_method_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/clear_all_prayer_tracker_data_usecase.dart';

class UsecaseSetup implements SetupModule {
  final GetIt _serviceLocator;
  UsecaseSetup(this._serviceLocator);

  @override
  Future<void> setup() async {
    log('init usecase setup');
    _serviceLocator
      ..registerLazySingleton(() => GetPrayerTimesUseCase(locate(), locate()))
      ..registerLazySingleton(() => GetActiveWaqtUseCase(locate(), locate()))
      ..registerLazySingleton(() => GetRemainingTimeUseCase(locate(), locate()))
      ..registerLazySingleton(() => GetJuristicMethodUseCase(locate()))
      ..registerLazySingleton(() => UpdateJuristicMethodUseCase(locate()))
      ..registerLazySingleton(
          () => SavePrayerTrackerUseCase(locate(), locate()))
      ..registerLazySingleton(
          () => GetPrayerTrackerDataUseCase(locate(), locate()))
      ..registerLazySingleton(
          () => GetAllPrayerTrackerDataUseCase(locate(), locate()))
      ..registerLazySingleton(
          () => ClearAllPrayerTrackerDataUseCase(locate(), locate()))
      ..registerLazySingleton(() => GetCountriesUseCase(locate(), locate()))
      ..registerLazySingleton(() => SearchCountriesUseCase(locate(), locate()))
      ..registerLazySingleton(() => GetLocationUseCase(locate(), locate()))
      ..registerLazySingleton(
          () => DetermineFirstRunUseCase(locate(), locate()))
      ..registerLazySingleton(() => SaveFirstTimeUseCase(locate(), locate()))
      ..registerLazySingleton(
          () => GetNotificationsUseCase(locate(), locate()));
  }
}
