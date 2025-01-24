import 'package:flutter/material.dart';
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
  final VoidCallback? actionButtonCallback;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    required this.isRead,
    this.actionUrl,
    this.imageUrl,
    this.actionButtonCallback,
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
        actionButtonCallback,
      ];
}
