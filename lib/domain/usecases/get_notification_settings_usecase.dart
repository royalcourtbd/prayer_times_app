import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/domain/repositories/notification_settings_repository.dart';

class GetNotificationSettingsUseCase {
  final NotificationSettingsRepository _repository;

  GetNotificationSettingsUseCase(this._repository);

  Future<Either<String, bool>> execute() async {
    try {
      final bool isEnabled = await _repository.getNotificationEnabled();
      return right(isEnabled);
    } catch (e) {
      return left(e.toString());
    }
  }
}
