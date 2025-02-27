import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/base/base_use_case.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_tracker_entity.dart';
import 'package:qibla_and_prayer_times/domain/repositories/prayer_tracker_repository.dart';
import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';

class GetAllPrayerTrackerDataUseCase
    extends BaseUseCase<List<PrayerTrackerHistoryEntity>> {
  final PrayerTrackerRepository _repository;

  GetAllPrayerTrackerDataUseCase(
    this._repository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, List<PrayerTrackerHistoryEntity>>> execute() async {
    return await _repository.getAllPrayerTrackerData();
  }
}
