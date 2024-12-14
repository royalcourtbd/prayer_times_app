import '../entities/country_entity.dart';

abstract class CountryRepository {
  Future<List<CountryNameEntity>> getAllCountries();
  Future<List<CountryNameEntity>> searchCountries(String query);
}
