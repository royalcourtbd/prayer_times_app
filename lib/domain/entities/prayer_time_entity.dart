import 'package:salat_times/core/base/base_entity.dart';

class PrayerTimeEntity extends BaseEntity {
  final DateTime startFajr;
  final DateTime fajrEnd;
  final DateTime sunrise; // Modified - previously fajrEnd
  final DateTime duhaStart; // New
  final DateTime duhaEnd; // New
  final DateTime startDhuhr;
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
    required this.sunrise, // Modified
    required this.duhaStart, // New
    required this.duhaEnd, // New
    required this.startDhuhr,
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
        sunrise,
        duhaStart,
        duhaEnd,
        startDhuhr,
        dhuhrEnd,
        startAsr,
        asrEnd,
        startMaghrib,
        maghribEnd,
        startIsha,
        ishaEnd,
      ];
}
