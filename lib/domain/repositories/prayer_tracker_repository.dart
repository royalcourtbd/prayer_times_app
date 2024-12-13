// lib/domain/repositories/prayer_tracker_repository.dart
import 'package:fpdart/fpdart.dart';

abstract class PrayerTrackerRepository {
  Future<Either<String, void>> savePrayerTrackerData(
      DateTime date, String trackerData);
  Future<Either<String, String?>> getPrayerTrackerData(DateTime date);
}
