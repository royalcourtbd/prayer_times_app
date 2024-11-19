// lib/domain/entities/prayer_time_entity.dart

import 'package:qibla_and_prayer_times/core/base/base_entity.dart';

class PrayerTimeEntity extends BaseEntity {
  final DateTime startFajr;
  final DateTime fajrEnd;
  final DateTime startDhuhr;
  final DateTime duhaStart;
  final DateTime duhaEnd;
  final DateTime dhuhrEnd;
  final DateTime startAsr;
  final DateTime asrEnd;
  final DateTime startMaghrib;
  final DateTime maghribEnd;
  final DateTime startIsha;
  final DateTime ishaEnd;

  const PrayerTimeEntity({
    required this.startFajr,
    required this.fajrEnd,
    required this.startDhuhr,
    required this.duhaStart,
    required this.duhaEnd,
    required this.dhuhrEnd,
    required this.startAsr,
    required this.asrEnd,
    required this.startMaghrib,
    required this.maghribEnd,
    required this.startIsha,
    required this.ishaEnd,
  });

  @override
  List<Object?> get props => [
        startFajr,
        fajrEnd,
        startDhuhr,
        duhaStart,
        duhaEnd,
        dhuhrEnd,
        startAsr,
        asrEnd,
        startMaghrib,
        maghribEnd,
        startIsha,
        ishaEnd,
      ];
}
