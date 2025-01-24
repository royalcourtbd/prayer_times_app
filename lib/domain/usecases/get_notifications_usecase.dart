import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/base/base_use_case.dart';
import 'package:qibla_and_prayer_times/domain/entities/notification_entity.dart';
import 'package:qibla_and_prayer_times/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase extends BaseUseCase<List<NotificationEntity>> {
  final NotificationRepository _repository;

  GetNotificationsUseCase(
    this._repository,
    super.errorMessageHandler,
  );

  Future<Either<String, List<NotificationEntity>>> execute() async {
    return _repository.getNotifications();
  }

  Future<Either<String, void>> markAsRead(String id) async {
    return _repository.markAsRead(id);
  }

  Future<Either<String, void>> clearAll() async {
    return _repository.clearAll();
  }
}
