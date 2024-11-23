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
      final DateTime today =
          DateTime(currentTime.year, currentTime.month, currentTime.day);

      // Add yesterday's Isha
      final DateTime yesterdayIsha =
          prayerTime.startIsha.subtract(const Duration(days: 1));
      prayers.add(MapEntry(WaqtType.isha, yesterdayIsha));

      // Add today's prayers
      prayers.addAll(_getTodaysPrayers(prayerTime));

      // Add tomorrow's Fajr
      final DateTime tomorrowFajr =
          prayerTime.startFajr.add(const Duration(days: 1));
      prayers.add(MapEntry(WaqtType.fajr, tomorrowFajr));

      // Calculate Isha End Time correctly
      final DateTime ishaEndTime = prayerTime.startFajr;

      if (currentTime.isAfter(ishaEndTime.subtract(const Duration(days: 1))) &&
          currentTime.isBefore(prayerTime.startFajr)) {
        prayers.add(MapEntry(WaqtType.isha, ishaEndTime));
      }

      // Sort prayers by time
      prayers.sort((a, b) => a.value.compareTo(b.value));

      WaqtType? activeType;
      WaqtType? nextType;

      // Special handling for time between midnight and Fajr
      if (currentTime.isAfter(today) &&
          currentTime.isBefore(prayerTime.startFajr)) {
        activeType = WaqtType.isha;
        nextType = WaqtType.fajr;
      } else {
        for (int i = 0; i < prayers.length; i++) {
          if (currentTime.isBefore(prayers[i].value)) {
            activeType = i > 0 ? prayers[i - 1].key : prayers.last.key;
            nextType = prayers[i].key;
            break;
          }
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
        double progress
      })> calculateRemainingTime({
    required DateTime currentWaqtTime,
    required DateTime nextWaqtTime,
    required DateTime currentTime,
  }) {
    try {
      DateTime adjustedNextWaqtTime = nextWaqtTime;
      DateTime adjustedCurrentWaqtTime = currentWaqtTime;

      // Handle midnight to Fajr period
      if (nextWaqtTime.isBefore(currentTime)) {
        adjustedNextWaqtTime = nextWaqtTime.add(const Duration(days: 1));
      }

      // For Isha prayer specially
      if (nextWaqtTime.hour < currentWaqtTime.hour &&
          currentTime.hour >= 0 &&
          currentTime.hour < 6) {
        adjustedCurrentWaqtTime =
            currentWaqtTime.subtract(const Duration(days: 1));
      }

      final Duration totalDuration =
          adjustedNextWaqtTime.difference(adjustedCurrentWaqtTime);
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
      case WaqtType.sunrise:
        return prayerTime.sunrise;
      case WaqtType.duha:
        return prayerTime.duhaStart;
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
      MapEntry(WaqtType.sunrise, prayerTime.sunrise),
      MapEntry(WaqtType.duha, prayerTime.duhaStart),
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
