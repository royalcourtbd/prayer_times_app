// prayer_time/models/prayer_tracker.dart

import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';

enum PrayerStatus {
  none,
  completed,
  missed;
}

class PrayerTrackerModel {
  final WaqtType type;
  final PrayerStatus status;
  final bool isSelectable;

  const PrayerTrackerModel({
    required this.type,
    this.status = PrayerStatus.none,
    this.isSelectable = false,
  });

  PrayerTrackerModel copyWith({
    WaqtType? type,
    PrayerStatus? status,
    bool? isSelectable,
  }) {
    return PrayerTrackerModel(
      type: type ?? this.type,
      status: status ?? this.status,
      isSelectable: isSelectable ?? this.isSelectable,
    );
  }
}
