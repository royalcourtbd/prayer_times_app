import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.description,
    required super.timestamp,
    required super.type,
    required super.isRead,
    super.actionButtonCallback,
    super.actionUrl,
    super.imageUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      timestamp: json['timestamp'],
      type: json['type'],
      isRead: json['isRead'],
      actionButtonCallback: json['actionButtonCallback'],
      actionUrl: json['actionUrl'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': timestamp,
      'type': type,
      'isRead': isRead,
      'actionButtonCallback': actionButtonCallback,
      'actionUrl': actionUrl,
      'imageUrl': imageUrl,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        timestamp,
        type,
        isRead,
        actionButtonCallback,
        actionUrl,
        imageUrl,
      ];

  NotificationModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? timestamp,
    String? type,
    bool? isRead,
    VoidCallback? actionButtonCallback,
    String? actionUrl,
    String? imageUrl,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      actionButtonCallback: actionButtonCallback ?? this.actionButtonCallback,
      actionUrl: actionUrl ?? this.actionUrl,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
