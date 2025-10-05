// lib/domain/repositories/prayer_tracker_repository.dart
import 'package:fpdart/fpdart.dart';
import 'package:salat_times/domain/entities/prayer_tracker_entity.dart';

abstract class PrayerTrackerRepository {
  Future<Either<String, void>> savePrayerTrackerData(
      DateTime date, String trackerData);
  Future<Either<String, String?>> getPrayerTrackerData(DateTime date);
  Future<Either<String, List<PrayerTrackerHistoryEntity>>>
      getAllPrayerTrackerData();
  Future<Either<String, void>> clearAllPrayerTrackerData();
}
