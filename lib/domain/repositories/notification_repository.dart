import 'package:fpdart/fpdart.dart';
import 'package:salat_times/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<String, List<NotificationEntity>>> getNotifications();
  Future<Either<String, void>> markAsRead(String id);
  Future<Either<String, void>> clearAll();
}
