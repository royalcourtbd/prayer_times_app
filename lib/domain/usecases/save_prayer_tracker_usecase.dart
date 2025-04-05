// lib/domain/usecases/save_prayer_tracker_usecase.dart

import 'package:fpdart/fpdart.dart';
import 'package:prayer_times/core/base/base_use_case.dart';
import 'package:prayer_times/domain/repositories/prayer_tracker_repository.dart';
import 'package:prayer_times/domain/service/error_message_handler.dart';

class SavePrayerTrackerUseCase extends BaseUseCase<void> {
  final PrayerTrackerRepository _repository;

  SavePrayerTrackerUseCase(
    this._repository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, void>> execute({
    required DateTime date,
    required String trackerData,
  }) async {
    return mapResultToEither(() async {
      final result = await _repository.savePrayerTrackerData(
        date,
        trackerData,
      );
      return result.fold(
        (l) => throw Exception(l),
        (r) => r,
      );
    });
  }
}
