import 'package:qibla_and_prayer_times/core/base/base_entity.dart';
import 'package:qibla_and_prayer_times/presentation/home/models/waqt.dart';

enum PrayerStatus {
  none,
  completed,
  missed;
}

class PrayerTrackerEntity extends BaseEntity {
  final String id;
  final WaqtType type;
  final PrayerStatus status;
  final bool isSelectable;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PrayerTrackerEntity({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.status = PrayerStatus.none,
    this.isSelectable = false,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        status,
        isSelectable,
        createdAt,
        updatedAt,
      ];
}

class PrayerTrackerHistoryEntity extends BaseEntity {
  final DateTime date;
  final String? trackerData;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PrayerTrackerHistoryEntity({
    required this.date,
    required this.trackerData,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        date,
        trackerData,
        createdAt,
        updatedAt,
      ];
}
