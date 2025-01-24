import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/domain/entities/notification_entity.dart';

class NotificationUiState extends BaseUiState {
  final List<NotificationEntity> notifications;
  final bool hasUnread;
  final BuildContext? context;

  const NotificationUiState({
    required super.isLoading,
    required super.userMessage,
    required this.notifications,
    required this.hasUnread,
    this.context,
  });

  factory NotificationUiState.empty() {
    return const NotificationUiState(
      isLoading: false,
      userMessage: '',
      notifications: [],
      hasUnread: false,
      context: null,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        notifications,
        hasUnread,
        context,
      ];

  NotificationUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<NotificationEntity>? notifications,
    bool? hasUnread,
    BuildContext? context,
  }) {
    return NotificationUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      notifications: notifications ?? this.notifications,
      hasUnread: hasUnread ?? this.hasUnread,
      context: context ?? this.context,
    );
  }
}
