import 'package:salat_times/core/base/base_presenter.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/domain/usecases/get_notifications_usecase.dart';
import 'package:salat_times/presentation/notification/presenter/notification_ui_state.dart';

class NotificationPresenter extends BasePresenter<NotificationUiState> {
  final GetNotificationsUseCase _getNotificationsUseCase;

  NotificationPresenter(this._getNotificationsUseCase);
  final Obs<NotificationUiState> uiState = Obs(NotificationUiState.empty());
  NotificationUiState get currentUiState => uiState.value;

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(message: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  Future<void> loadNotifications() async {
    await parseDataFromEitherWithUserMessage(
      task: () => _getNotificationsUseCase.execute(),
      onDataLoaded: (notifications) {
        final bool hasUnread =
            notifications.any((notification) => !notification.isRead);
        uiState.value = currentUiState.copyWith(
          notifications: notifications,
          hasUnread: hasUnread,
        );
      },
      showLoading: true,
    );
  }

  Future<void> markAsRead(String id) async {
    await parseDataFromEitherWithUserMessage(
      task: () => _getNotificationsUseCase.markAsRead(id),
      onDataLoaded: (data) {
        loadNotifications();
      },
      showLoading: true,
    );
  }

  Future<void> clearAll() async {
    await parseDataFromEitherWithUserMessage(
      task: () => _getNotificationsUseCase.clearAll(),
      onDataLoaded: (data) {
        loadNotifications();
      },
      showLoading: true,
    );
  }

  @override
  void onInit() {
    loadNotifications();
    super.onInit();
  }
}
