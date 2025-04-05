// lib/data/datasources/prayer_time_datasource.dart

import 'package:adhan/adhan.dart';
import 'package:fpdart/fpdart.dart';
import 'package:prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:prayer_times/domain/repositories/juristic_method_repository.dart';

abstract class PrayerTimeDataSource {
  Future<PrayerTimeEntity> getPrayerTimes({
    required double latitude,
    required double longitude,
    DateTime? date,
  });
}

class PrayerTimeDataSourceImpl implements PrayerTimeDataSource {
  final JuristicMethodRepository _juristicMethodRepository;

  PrayerTimeDataSourceImpl(this._juristicMethodRepository);

  @override
  Future<PrayerTimeEntity> getPrayerTimes({
    required double latitude,
    required double longitude,
    DateTime? date,
  }) async {
    final Either<String, String> methodResult =
        await _juristicMethodRepository.getJuristicMethod();

    return methodResult.fold(
      (error) => throw Exception(error),
      (method) async {
        final Coordinates coordinates = Coordinates(latitude, longitude);
        final CalculationParameters params =
            CalculationMethod.karachi.getParameters();

        params.madhab = method == 'Hanafi' ? Madhab.hanafi : Madhab.shafi;

        // Use the provided date or fallback to current date
        final DateTime prayerDate = date ?? DateTime.now();
        final PrayerTimes prayerTimes = PrayerTimes(
          coordinates,
          DateComponents(prayerDate.year, prayerDate.month, prayerDate.day),
          params,
        );

        return PrayerTimeEntity(
          startFajr: prayerTimes.fajr,
          fajrEnd: prayerTimes.sunrise,
          sunrise: prayerTimes.sunrise,
          duhaStart: prayerTimes.sunrise.add(const Duration(minutes: 15)),
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
      },
    );
  }
}
