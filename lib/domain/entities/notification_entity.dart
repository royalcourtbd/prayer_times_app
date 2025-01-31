import 'package:qibla_and_prayer_times/core/base/base_entity.dart';

class NotificationEntity extends BaseEntity {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final String type;
  final bool isRead;
  final String? actionUrl;
  final String? imageUrl;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    required this.isRead,
    this.actionUrl,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        timestamp,
        type,
        isRead,
        actionUrl,
        imageUrl,
      ];
}
