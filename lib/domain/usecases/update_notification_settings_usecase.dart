import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/domain/repositories/notification_settings_repository.dart';

class UpdateNotificationSettingsUseCase {
  final NotificationSettingsRepository _repository;

  UpdateNotificationSettingsUseCase(this._repository);

  Future<Either<String, void>> execute({required bool isEnabled}) async {
    try {
      await _repository.updateNotificationEnabled(isEnabled);
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }
}
