// lib/domain/entities/prayer_time_entity.dart

import 'package:qibla_and_prayer_times/core/base/base_entity.dart';

class PrayerTimeEntity extends BaseEntity {
  final DateTime fajr;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;

  const PrayerTimeEntity({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  @override
  List<Object?> get props => [fajr, dhuhr, asr, maghrib, isha];
}
