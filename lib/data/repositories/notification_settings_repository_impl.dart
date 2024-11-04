import 'package:qibla_and_prayer_times/data/services/database/prayer_database.dart';
import 'package:qibla_and_prayer_times/domain/repositories/notification_settings_repository.dart';

class NotificationSettingsRepositoryImpl
    implements NotificationSettingsRepository {
  final PrayerDatabase _database;

  NotificationSettingsRepositoryImpl(this._database);

  @override
  Future<bool> getNotificationEnabled() {
    return _database.getNotificationEnabled();
  }

  @override
  Future<void> updateNotificationEnabled(bool isEnabled) {
    return _database.updateNotificationEnabled(isEnabled);
  }
}
