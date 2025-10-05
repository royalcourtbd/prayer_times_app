// lib/domain/usecases/get_prayer_tracker_data_usecase.dart

import 'package:fpdart/fpdart.dart';
import 'package:salat_times/core/base/base_use_case.dart';
import 'package:salat_times/domain/repositories/prayer_tracker_repository.dart';
import 'package:salat_times/domain/service/error_message_handler.dart';

class GetPrayerTrackerDataUseCase extends BaseUseCase<String?> {
  final PrayerTrackerRepository _repository;

  GetPrayerTrackerDataUseCase(
    this._repository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, String?>> execute({
    required DateTime date,
  }) async {
    return mapResultToEither(() async {
      final result = await _repository.getPrayerTrackerData(date);
      return result.fold(
        (l) => throw Exception(l),
        (r) => r,
      );
    });
  }
}
