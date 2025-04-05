import 'package:get_it/get_it.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/di/setup/setup_module.dart';
import 'package:qibla_and_prayer_times/data/datasources/local/country_local_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/local/location_local_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/local/user_data_local_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/remote/device_info_remote_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/remote/location_remote_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/remote/prayer_time_datasource.dart';
import 'package:qibla_and_prayer_times/data/datasources/remote/payment_remote_data_source.dart';

class DatasourceSetup implements SetupModule {
  final GetIt _serviceLocator;
  DatasourceSetup(this._serviceLocator);

  @override
  Future<void> setup() async {
    _serviceLocator
      ..registerLazySingleton<PrayerTimeDataSource>(
          () => PrayerTimeDataSourceImpl(locate()))
      ..registerLazySingleton(() => CountryLocalDataSource())
      ..registerLazySingleton<LocationLocalDataSource>(
          () => LocationLocalDataSourceImpl(locate()))
      ..registerLazySingleton<LocationRemoteDataSource>(
          () => LocationRemoteDataSourceImpl())
      ..registerLazySingleton(() => UserDataLocalDataSource(locate()))
      ..registerLazySingleton<DeviceInfoRemoteDataSource>(
          () => DeviceInfoRemoteDataSourceImpl(locate()))
      ..registerLazySingleton<PaymentRemoteDataSource>(
        () => PaymentRemoteDataSourceImpl(locate()),
      );
  }
}
