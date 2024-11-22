// lib/data/services/waqt_calculation_service_impl.dart

import 'package:fpdart/fpdart.dart';
import '../../domain/service/waqt_calculation_service.dart';
import '../../domain/entities/prayer_time_entity.dart';
import '../../presentation/prayer_time/models/waqt.dart';

class WaqtCalculationServiceImpl implements WaqtCalculationService {
  @override
  Either<String, ({WaqtType activeWaqt, WaqtType nextWaqt})>
      calculateActiveWaqt({
    required PrayerTimeEntity prayerTime,
    required DateTime currentTime,
  }) {
    try {
      final List<MapEntry<WaqtType, DateTime>> prayers = [];

      // Add today's prayers
      prayers.addAll(_getTodaysPrayers(prayerTime));

      // Add tomorrow's Fajr
      final DateTime tomorrowFajr =
          prayerTime.startFajr.add(const Duration(days: 1));
      prayers.add(MapEntry(WaqtType.fajr, tomorrowFajr));

      // Sort prayers by time
      prayers.sort((a, b) => a.value.compareTo(b.value));

      WaqtType? activeType;
      WaqtType? nextType;

      for (int i = 0; i < prayers.length; i++) {
        if (currentTime.isBefore(prayers[i].value)) {
          activeType = i > 0 ? prayers[i - 1].key : prayers.last.key;
          nextType = prayers[i].key;
          break;
        }
      }

      if (activeType == null || nextType == null) {
        return left('Invalid prayer times');
      }

      return right((activeWaqt: activeType, nextWaqt: nextType));
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
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
  }) {
    try {
      DateTime adjustedNextWaqtTime = nextWaqtTime;
      if (nextWaqtTime.isBefore(currentTime)) {
        adjustedNextWaqtTime = nextWaqtTime.add(const Duration(days: 1));
      }

      final Duration totalDuration =
          adjustedNextWaqtTime.difference(currentWaqtTime);
      final Duration remainingDuration =
          adjustedNextWaqtTime.difference(currentTime);

      final Duration validRemainingDuration =
          remainingDuration.isNegative ? const Duration() : remainingDuration;

      final double progress =
          _calculateProgress(totalDuration, validRemainingDuration);

      return right((
        remainingDuration: validRemainingDuration,
        totalDuration: totalDuration,
        progress: progress,
      ));
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  DateTime? getWaqtTime(WaqtType type, PrayerTimeEntity prayerTime) {
    switch (type) {
      case WaqtType.fajr:
        return prayerTime.startFajr;
      case WaqtType.dhuhr:
        return prayerTime.startDhuhr;
      case WaqtType.asr:
        return prayerTime.startAsr;
      case WaqtType.maghrib:
        return prayerTime.startMaghrib;
      case WaqtType.isha:
        return prayerTime.startIsha;
    }
  }

  List<MapEntry<WaqtType, DateTime>> _getTodaysPrayers(
      PrayerTimeEntity prayerTime) {
    return [
      MapEntry(WaqtType.fajr, prayerTime.startFajr),
      MapEntry(WaqtType.dhuhr, prayerTime.startDhuhr),
      MapEntry(WaqtType.asr, prayerTime.startAsr),
      MapEntry(WaqtType.maghrib, prayerTime.startMaghrib),
      MapEntry(WaqtType.isha, prayerTime.startIsha),
    ];
  }

  double _calculateProgress(Duration total, Duration remaining) {
    return ((total.inSeconds - remaining.inSeconds) / total.inSeconds * 100)
        .clamp(0, 100);
  }
}
