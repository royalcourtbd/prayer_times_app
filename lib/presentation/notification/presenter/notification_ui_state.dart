import 'package:prayer_times/core/base/base_ui_state.dart';
import 'package:prayer_times/domain/entities/notification_entity.dart';

class NotificationUiState extends BaseUiState {
  final List<NotificationEntity> notifications;
  final bool hasUnread;

  const NotificationUiState({
    required super.isLoading,
    required super.userMessage,
    required this.notifications,
    required this.hasUnread,
  });

  factory NotificationUiState.empty() {
    return const NotificationUiState(
      isLoading: false,
      userMessage: '',
      notifications: [],
      hasUnread: false,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        notifications,
        hasUnread,
      ];

  NotificationUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<NotificationEntity>? notifications,
    bool? hasUnread,
  }) {
    return NotificationUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      notifications: notifications ?? this.notifications,
      hasUnread: hasUnread ?? this.hasUnread,
    );
  }
}
