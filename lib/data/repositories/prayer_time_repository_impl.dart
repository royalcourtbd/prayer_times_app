// lib/data/repositories/prayer_time_repository_impl.dart

import 'package:fpdart/fpdart.dart';
import 'package:salat_times/data/datasources/remote/prayer_time_datasource.dart';
import 'package:salat_times/domain/entities/prayer_time_entity.dart';
import 'package:salat_times/domain/repositories/prayer_time_repository.dart';

class PrayerTimeRepositoryImpl implements PrayerTimeRepository {
  final PrayerTimeDataSource _dataSource;

  PrayerTimeRepositoryImpl(this._dataSource);

  @override
  Future<Either<String, PrayerTimeEntity>> getPrayerTimes({
    required double latitude,
    required double longitude,
    DateTime? date,
  }) async {
    try {
      final PrayerTimeEntity result = await _dataSource.getPrayerTimes(
        latitude: latitude,
        longitude: longitude,
        date: date,
      );
      return right(result);
    } catch (e) {
      return left(e.toString());
    }
  }
}
