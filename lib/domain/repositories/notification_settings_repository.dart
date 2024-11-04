abstract class NotificationSettingsRepository {
  Future<bool> getNotificationEnabled();
  Future<void> updateNotificationEnabled(bool isEnabled);
}
