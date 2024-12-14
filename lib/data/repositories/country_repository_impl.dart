import '../../domain/entities/country.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasources/local/country_local_data_source.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryLocalDataSource _localDataSource;

  CountryRepositoryImpl( this._localDataSource);

  @override
  Future<List<Country>> getAllCountries() async {
    return await _localDataSource.getAllCountries();
  }

  @override
  Future<List<Country>> searchCountries(String query) async {
    final countries = await _localDataSource.getAllCountries();
    return countries
        .where((country) =>
            country.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
