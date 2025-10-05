import 'package:fpdart/fpdart.dart';
import 'package:salat_times/core/base/base_use_case.dart';
import 'package:salat_times/domain/entities/prayer_tracker_entity.dart';
import 'package:salat_times/domain/repositories/prayer_tracker_repository.dart';
import 'package:salat_times/domain/service/error_message_handler.dart';

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
