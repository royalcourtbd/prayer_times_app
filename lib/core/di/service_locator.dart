import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/data/datasources/local/country_local_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/local/location_local_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/local/user_data_local_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/remote/location_remote_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/remote/prayer_time_datasource.dart';
import 'package:qibla_and_prayer_times/data/repositories/country_repository_impl.dart';
import 'package:qibla_and_prayer_times/data/repositories/juristic_method_repository_impl.dart';
import 'package:qibla_and_prayer_times/data/repositories/location_repository_impl.dart';
import 'package:qibla_and_prayer_times/data/repositories/prayer_time_repository_impl.dart';
import 'package:qibla_and_prayer_times/data/repositories/prayer_tracker_repository_impl.dart';
import 'package:qibla_and_prayer_times/data/repositories/user_data_repository_impl.dart';
import 'package:qibla_and_prayer_times/data/services/database/prayer_database.dart';
import 'package:qibla_and_prayer_times/data/services/error_message_handler_impl.dart';
import 'package:qibla_and_prayer_times/data/services/local_cache_service.dart';
import 'package:qibla_and_prayer_times/data/services/location_service.dart';
import 'package:qibla_and_prayer_times/data/services/waqt_calculation_service_impl.dart';
import 'package:qibla_and_prayer_times/domain/repositories/country_repository.dart';
import 'package:qibla_and_prayer_times/domain/repositories/juristic_method_repository.dart';
import 'package:qibla_and_prayer_times/domain/repositories/location_repository.dart';
import 'package:qibla_and_prayer_times/domain/repositories/prayer_time_repository.dart';
import 'package:qibla_and_prayer_times/domain/repositories/prayer_tracker_repository.dart';
import 'package:qibla_and_prayer_times/domain/repositories/user_data_repository.dart';
import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';
import 'package:qibla_and_prayer_times/domain/service/time_service.dart';
import 'package:qibla_and_prayer_times/domain/service/waqt_calculation_service.dart';
import 'package:qibla_and_prayer_times/domain/usecases/determine_first_run_use_case.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_active_waqt_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_countries_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_juristic_method_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_location_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_tracker_data_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_remaining_time_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/save_first_time_use_case.dart';
import 'package:qibla_and_prayer_times/domain/usecases/save_prayer_tracker_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/search_countries_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/update_juristic_method_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/onboarding/presenter/onboarding_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_presenter.dart';

// Implementation Note:
//
// The app utilizes the **Service Locator Pattern** to manage dependencies.
//
// The Service Locator Pattern is a design pattern that improves modularity and
// maintainability in our codebase. By decoupling the code from direct dependency
// references, it allows for easier substitution or addition of dependencies in
// the future.
//
// To understand the Service Locator Pattern in more detail, you can refer to
// the following resource: https://stackify.com/service-locator-pattern/.
//
// This pattern simplifies the process of replacing or adding dependencies.
// Instead of modifying every object that relies on a particular dependency, we
// only need to update the service locator itself. This centralization reduces
// code changes and minimizes potential errors.
final GetIt _serviceLocator = GetIt.instance;

// This code implements a wrapper function around the `get` function from the
// `get_it` package. The purpose of this wrapper is to provide a simplified and
// centralized way of retrieving registered instances of classes.
//
// By using this wrapper instead of directly calling the get function, we avoid
// tight coupling to the specific service locator implementation, which can lead
// to vendor lock-in. This abstraction allows for flexibility in choosing a
// different service locator plugin in the future if needed.
//
// The wrapper function encapsulates the complexity of the service locator and
// provides a cleaner and more readable interface for retrieving dependencies
// throughout the codebase.

/// Provides a way to retrieve an instance of a class registered
/// with the service locator.
T locate<T extends Object>() => _serviceLocator.get<T>();

void dislocate<T extends BasePresenter>() => unloadPresenterManually<T>();

class ServiceLocator {
  ServiceLocator._();

  /// Sets up the whole dependency injection system by calling various setup
  /// methods in a certain order.
  ///
  /// Also provides an optional flag to only start services and skip the other
  /// setup steps.
  ///
  /// Ensures that all necessary dependencies are initialized before starting
  /// the application.
  static Future<void> setUp({bool startOnlyService = false}) async {
    final ServiceLocator locator = ServiceLocator._();
    await locator._setUpServices();
    if (startOnlyService) return;
    await locator._setUpDataSources();
    await locator._setUpRepositories();
    await locator._setUpUseCase();
    await locator._setUpPresenters();
  }

  Future<void> _setUpFirebaseServices() async {}

  Future<void> _setUpAudioService() async {}

  Future<void> _setUpRepositories() async {
    _serviceLocator
      ..registerLazySingleton<PrayerTimeRepository>(
          () => PrayerTimeRepositoryImpl(locate()))
      ..registerLazySingleton<JuristicMethodRepository>(
          () => JuristicMethodRepositoryImpl(locate()))
      ..registerLazySingleton<PrayerTrackerRepository>(
          () => PrayerTrackerRepositoryImpl(locate()))
      ..registerLazySingleton<CountryRepository>(
          () => CountryRepositoryImpl(locate()))
      ..registerLazySingleton<LocationRepository>(
          () => LocationRepositoryImpl(locate(), locate(), locate()))
      ..registerLazySingleton<UserDataRepository>(
          () => UserDataRepositoryImpl(locate()));
  }

  Future<void> _setUpServices() async {
    _serviceLocator
      ..registerLazySingleton<ErrorMessageHandler>(
          () => ErrorMessageHandlerImpl())
      ..registerLazySingleton<WaqtCalculationService>(
          () => WaqtCalculationServiceImpl())
      ..registerLazySingleton(() => TimeService())
      ..registerLazySingleton(() => PrayerDatabase())
      ..registerLazySingleton(() => LocationService())
      ..registerLazySingleton(() => LocalCacheService());
    await LocalCacheService.setUp();
    await _setUpAudioService();
    await _setUpFirebaseServices();
  }

  Future<void> _setUpDataSources() async {
    _serviceLocator
      ..registerLazySingleton<PrayerTimeDataSource>(
          () => PrayerTimeDataSourceImpl(locate()))
      ..registerLazySingleton(() => CountryLocalDataSource())
      ..registerLazySingleton<LocationLocalDataSource>(
          () => LocationLocalDataSourceImpl(locate()))
      ..registerLazySingleton<LocationRemoteDataSource>(
          () => LocationRemoteDataSourceImpl())
      ..registerLazySingleton(() => UserDataLocalDataSource(locate()));
  }

  Future<void> _setUpPresenters() async {
    _serviceLocator
      ..registerFactory(() => loadPresenter(MainPresenter(locate())))
      ..registerLazySingleton(() => loadPresenter(PrayerTimePresenter(
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
            locate(),
          )))
      ..registerLazySingleton(
          () => PrayerTrackerPresenter(locate(), locate(), locate(), locate()))
      ..registerLazySingleton(() => ProfilePagePresenter())
      ..registerLazySingleton(() => SettingsPagePresenter(
            locate(),
            locate(),
            locate(),
            locate(),
          ))
      ..registerLazySingleton(() => OnboardingPresenter(locate(), locate()));
  }

  Future<void> _setUpUseCase() async {
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
      ..registerLazySingleton(() => GetCountriesUseCase(locate(), locate()))
      ..registerLazySingleton(() => SearchCountriesUseCase(locate(), locate()))
      ..registerLazySingleton(() => GetLocationUseCase(locate(), locate()))
      ..registerLazySingleton(
          () => DetermineFirstRunUseCase(locate(), locate()))
      ..registerLazySingleton(() => SaveFirstTimeUseCase(locate(), locate()));
  }
}
