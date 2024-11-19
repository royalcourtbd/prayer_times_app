// lib/data/datasources/prayer_time_datasource.dart

import 'package:adhan/adhan.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';

abstract class PrayerTimeDataSource {
  Future<PrayerTimeEntity> getPrayerTimes({
    required double latitude,
    required double longitude,
  });
}

class PrayerTimeDataSourceImpl implements PrayerTimeDataSource {
  @override
  Future<PrayerTimeEntity> getPrayerTimes({
    required double latitude,
    required double longitude,
  }) async {
    final Coordinates coordinates = Coordinates(latitude, longitude);
    final CalculationParameters params =
        CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.shafi;

    final DateTime date = DateTime.now();
    final PrayerTimes prayerTimes = PrayerTimes(
      coordinates,
      DateComponents(date.year, date.month, date.day),
      params,
    );

    return PrayerTimeEntity(
      startFajr: prayerTimes.fajr,
      fajrEnd: prayerTimes.sunrise,
      duhaStart: prayerTimes.sunrise,
      duhaEnd: prayerTimes.dhuhr,
      startDhuhr: prayerTimes.dhuhr,
      dhuhrEnd: prayerTimes.asr,
      startAsr: prayerTimes.asr,
      asrEnd: prayerTimes.maghrib,
      startMaghrib: prayerTimes.maghrib,
      maghribEnd: prayerTimes.isha,
      startIsha: prayerTimes.isha,
      ishaEnd: prayerTimes.fajr.add(const Duration(days: 1)),
    );
  }
}
