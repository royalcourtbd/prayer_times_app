import 'package:salat_times/core/base/base_entity.dart';

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
}
