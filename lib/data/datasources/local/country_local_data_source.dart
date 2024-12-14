import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../domain/entities/country_entity.dart';

class CountryLocalDataSource {
  Future<List<CountryNameEntity>> getAllCountries() async {
    final String response =
        await rootBundle.loadString('assets/db/country.json');
    final List<dynamic> data = json.decode(response);
    return data.map((e) => _mapJsonToCountry(e)).toList();
  }

  CountryNameEntity _mapJsonToCountry(Map<String, dynamic> json) {
    return CountryNameEntity(
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

  CityNameEntity _mapJsonToCity(Map<String, dynamic> json) {
    return CityNameEntity(
      name: json['name'],
      timezone: json['timezone'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
