// lib/data/services/database/prayer_database.dart

import 'package:drift/drift.dart';

import 'package:qibla_and_prayer_times/data/services/database/table/notification_settings_table.dart';
import 'package:qibla_and_prayer_times/data/services/database/table/juristic_method_table.dart';
import 'package:qibla_and_prayer_times/data/services/database_loader.dart';

part 'prayer_database.g.dart';

@DriftDatabase(tables: [NotificationSettingsTable, JuristicMethodTable])
class PrayerDatabase extends _$PrayerDatabase {
  PrayerDatabase({QueryExecutor? queryExecutor})
      : super(queryExecutor ?? loadDatabase());

  @override
  int get schemaVersion => 1;

  Future<bool> getNotificationEnabled() async {
    final result = await (select(notificationSettingsTable)
          ..limit(1)
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .getSingleOrNull();
    return result?.isEnabled ?? true;
  }

  Future<void> updateNotificationEnabled(bool isEnabled) async {
    await into(notificationSettingsTable).insert(
      NotificationSettingsTableCompanion.insert(
        isEnabled: Value(isEnabled),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<String> getJuristicMethod() async {
    final result = await (select(juristicMethodTable)
          ..limit(1)
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .getSingleOrNull();
    return result?.method ?? 'Shafi';
  }

  Future<void> updateJuristicMethod(String method) async {
    await into(juristicMethodTable).insert(
      JuristicMethodTableCompanion.insert(
        method: method,
        updatedAt: DateTime.now(),
      ),
    );
  }
}
