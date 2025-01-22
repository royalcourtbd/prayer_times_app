import 'package:hive/hive.dart';
import 'package:qibla_and_prayer_times/core/base/base_entity.dart';

part 'location_entity.g.dart';

@HiveType(typeId: 1)
class LocationEntity extends BaseEntity {
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final String? placeName;

  const LocationEntity({
    required this.latitude,
    required this.longitude,
    this.placeName,
  });

  @override
  List<Object?> get props => [latitude, longitude, placeName];

  LocationEntity copyWith({
    double? latitude,
    double? longitude,
    String? placeName,
  }) {
    return LocationEntity(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      placeName: placeName ?? this.placeName,
    );
  }
}
