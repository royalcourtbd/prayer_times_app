import 'package:qibla_and_prayer_times/core/base/base_entity.dart';

class LocationEntity extends BaseEntity {
  final double latitude;
  final double longitude;
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
