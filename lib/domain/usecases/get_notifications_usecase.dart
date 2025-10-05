import 'package:fpdart/fpdart.dart';
import 'package:salat_times/core/base/base_use_case.dart';
import 'package:salat_times/domain/entities/notification_entity.dart';
import 'package:salat_times/domain/repositories/notification_repository.dart';

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
