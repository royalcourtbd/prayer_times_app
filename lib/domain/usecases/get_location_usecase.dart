import 'package:fpdart/fpdart.dart';
import 'package:prayer_times/core/base/base_use_case.dart';
import 'package:prayer_times/domain/entities/location_entity.dart';
import 'package:prayer_times/domain/repositories/location_repository.dart';
import 'package:prayer_times/domain/service/error_message_handler.dart';

class GetLocationUseCase extends BaseUseCase<LocationEntity> {
  final LocationRepository _repository;

  GetLocationUseCase(
    this._repository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, LocationEntity>> execute(
      {bool forceRemote = false}) async {
    return mapResultToEither(() async {
      final Either<String, LocationEntity> result =
          await _repository.getLocation(forceRemote: forceRemote);
      return result.fold(
        (l) => throw Exception(l),
        (r) => r,
      );
    });
  }
}
