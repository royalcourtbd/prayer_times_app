import 'package:fpdart/fpdart.dart';
import 'package:salat_times/core/base/base_use_case.dart';
import 'package:salat_times/domain/repositories/prayer_tracker_repository.dart';
import 'package:salat_times/domain/service/error_message_handler.dart';

class ClearAllPrayerTrackerDataUseCase extends BaseUseCase<void> {
  final PrayerTrackerRepository _repository;

  ClearAllPrayerTrackerDataUseCase(
    this._repository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, void>> execute() async {
    return await _repository.clearAllPrayerTrackerData();
  }
}
