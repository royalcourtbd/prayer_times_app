import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../domain/entities/country.dart';

class CountryLocalDataSource {
  Future<List<Country>> getAllCountries() async {
    final String response =
        await rootBundle.loadString('assets/db/country.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => _mapJsonToCountry(e)).toList();
  }

  Country _mapJsonToCountry(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      timezone: json['timezone'],
      code: json['code'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      cities: (json['cities'] as List<dynamic>?)
              ?.map((cityJson) => _mapJsonToCity(cityJson))
              .toList() ??
          [],
    );
  }

  City _mapJsonToCity(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      timezone: json['timezone'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
