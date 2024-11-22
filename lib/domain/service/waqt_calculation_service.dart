// lib/domain/service/waqt_calculation_service.dart

import 'package:fpdart/fpdart.dart';
import '../entities/prayer_time_entity.dart';
import '../../presentation/prayer_time/models/waqt.dart';

abstract class WaqtCalculationService {
  Either<String, ({WaqtType activeWaqt, WaqtType nextWaqt})>
      calculateActiveWaqt({
    required PrayerTimeEntity prayerTime,
    required DateTime currentTime,
  });

  Either<
      String,
      ({
        Duration remainingDuration,
        Duration totalDuration,
        double progress,
      })> calculateRemainingTime({
    required DateTime currentWaqtTime,
    required DateTime nextWaqtTime,
    required DateTime currentTime,
  });

  DateTime? getWaqtTime(WaqtType type, PrayerTimeEntity prayerTime);
}
