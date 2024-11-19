// lib/domain/entities/prayer_time_entity.dart

import 'package:qibla_and_prayer_times/core/base/base_entity.dart';

class PrayerTimeEntity extends BaseEntity {
  final DateTime startFajr;
  final DateTime startDhuhr;
  final DateTime startAsr;
  final DateTime startMaghrib;
  final DateTime startIsha;

  const PrayerTimeEntity({
    required this.startFajr,
    required this.startDhuhr,
    required this.startAsr,
    required this.startMaghrib,
    required this.startIsha,
  });

  @override
  List<Object?> get props =>
      [startFajr, startDhuhr, startAsr, startMaghrib, startIsha];
}
