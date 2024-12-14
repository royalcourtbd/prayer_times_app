import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/base/base_use_case.dart';
import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';

import '../entities/country.dart';
import '../repositories/country_repository.dart';

class GetCountriesUseCase extends BaseUseCase<List<Country>> {
  final CountryRepository repository;

  GetCountriesUseCase(
    this.repository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, List<Country>>> execute() async {
    return mapResultToEither(() async {
      final List<Country> result = await repository.getAllCountries();
      return result;
    });
  }
}
