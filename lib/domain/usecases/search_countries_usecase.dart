import 'package:fpdart/fpdart.dart';
import 'package:salat_times/core/base/base_use_case.dart';
import 'package:salat_times/domain/service/error_message_handler.dart';

import '../entities/country_entity.dart';
import '../repositories/country_repository.dart';

class SearchCountriesUseCase extends BaseUseCase<List<CountryNameEntity>> {
  final CountryRepository repository;

  SearchCountriesUseCase(
    this.repository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, List<CountryNameEntity>>> execute({
    required String searchQuery,
  }) async {
    return mapResultToEither(() async {
      final List<CountryNameEntity> result =
          await repository.searchCountries(searchQuery);
      return result;
    });
  }
}
