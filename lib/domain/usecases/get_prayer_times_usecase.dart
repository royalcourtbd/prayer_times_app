// lib/domain/usecases/get_prayer_times_usecase.dart

import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/base/base_use_case.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/domain/repositories/prayer_time_repository.dart';
import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';

class GetPrayerTimesUseCase extends BaseUseCase<PrayerTimeEntity> {
  final PrayerTimeRepository _repository;

  GetPrayerTimesUseCase(
    this._repository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, PrayerTimeEntity>> execute({
    required double latitude,
    required double longitude,
    DateTime? date,
  }) async {
    return mapResultToEither(() async {
      final Either<String, PrayerTimeEntity> result =
          await _repository.getPrayerTimes(
        latitude: latitude,
        longitude: longitude,
        date: date,
      );
      return result.fold(
        (l) => throw Exception(l),
        (r) => r,
      );
    });
  }
}
