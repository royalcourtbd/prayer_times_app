import 'package:fpdart/fpdart.dart';
import 'package:salat_times/domain/entities/prayer_time_entity.dart';

abstract class PrayerTimeRepository {
  Future<Either<String, PrayerTimeEntity>> getPrayerTimes({
    required double latitude,
    required double longitude,
    DateTime? date,
  });
}
