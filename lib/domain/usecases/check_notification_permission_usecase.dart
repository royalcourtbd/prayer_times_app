import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/base/base_use_case.dart';
import 'package:qibla_and_prayer_times/domain/service/notification_service.dart';
import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';

class CheckNotificationPermissionUsecase extends BaseUseCase<bool> {
  final NotificationService _notificationService;

  CheckNotificationPermissionUsecase(
    this._notificationService,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, bool>> execute() async {
    return mapResultToEither(() async {
      return await _notificationService.isNotificationAllowed();
    });
  }
}
