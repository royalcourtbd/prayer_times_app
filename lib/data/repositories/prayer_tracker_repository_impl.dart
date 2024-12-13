// lib/data/repositories/prayer_tracker_repository_impl.dart

import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/data/services/database/prayer_database.dart';
import 'package:qibla_and_prayer_times/domain/repositories/prayer_tracker_repository.dart';

class PrayerTrackerRepositoryImpl implements PrayerTrackerRepository {
  final PrayerDatabase _database;

  PrayerTrackerRepositoryImpl(this._database);

  @override
  Future<Either<String, void>> savePrayerTrackerData(
      DateTime date, String trackerData) async {
    try {
      await _database.insertOrUpdatePrayerTrackerData(date, trackerData);
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String?>> getPrayerTrackerData(DateTime date) async {
    try {
      final String? trackerData = await _database.getPrayerTrackerData(date);
      return right(trackerData);
    } catch (e) {
      return left(e.toString());
    }
  }
}
