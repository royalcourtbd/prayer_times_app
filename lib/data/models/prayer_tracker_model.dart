import 'package:salat_times/domain/entities/prayer_tracker_entity.dart';
import 'package:salat_times/presentation/home/models/waqt.dart';

class PrayerTrackerModel extends PrayerTrackerEntity {
  const PrayerTrackerModel({
    required super.id,
    required super.type,
    required super.createdAt,
    required super.updatedAt,
    super.status,
    super.isSelectable,
  });

  factory PrayerTrackerModel.fromJson(Map<String, dynamic> json) {
    return PrayerTrackerModel(
      id: json['id'] as String,
      type: WaqtType.values[json['type'] as int],
      status: PrayerStatus.values[json['status'] as int],
      isSelectable: json['isSelectable'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'status': status.index,
      'isSelectable': isSelectable,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  PrayerTrackerModel copyWith({
    String? id,
    WaqtType? type,
    PrayerStatus? status,
    bool? isSelectable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PrayerTrackerModel(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      isSelectable: isSelectable ?? this.isSelectable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
