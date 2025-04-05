import 'package:prayer_times/core/base/base_entity.dart';

class RamadanDayEntity extends BaseEntity {
  final String day;
  final String date;
  final String weekday;
  final String hijriDate;
  final String sehriTime;
  final String iftarTime;

  const RamadanDayEntity({
    required this.day,
    required this.date,
    required this.weekday,
    required this.hijriDate,
    required this.sehriTime,
    required this.iftarTime,
  });

  @override
  List<Object?> get props =>
      [day, date, weekday, hijriDate, sehriTime, iftarTime];
}
