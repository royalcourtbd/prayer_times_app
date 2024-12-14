class Country {
  final String name;
  final String timezone;
  final String code;
  final double latitude;
  final double longitude;
  final List<City> cities;

  Country({
    required this.name,
    required this.timezone,
    required this.code,
    required this.latitude,
    required this.longitude,
    required this.cities,
  });
}

class City {
  final String name;
  final String timezone;
  final double latitude;
  final double longitude;

  City({
    required this.name,
    required this.timezone,
    required this.latitude,
    required this.longitude,
  });
}
