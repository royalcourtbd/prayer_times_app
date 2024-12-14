class CountryNameEntity {
  final String name;
  final String timezone;
  final String code;
  final double latitude;
  final double longitude;
  final List<CityNameEntity> cities;

  CountryNameEntity({
    required this.name,
    required this.timezone,
    required this.code,
    required this.latitude,
    required this.longitude,
    required this.cities,
  });
}

class CityNameEntity {
  final String name;
  final String timezone;
  final double latitude;
  final double longitude;

  CityNameEntity({
    required this.name,
    required this.timezone,
    required this.latitude,
    required this.longitude,
  });
}
