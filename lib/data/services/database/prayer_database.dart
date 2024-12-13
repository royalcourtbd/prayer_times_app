// lib/data/services/database/prayer_database.dart

import 'package:drift/drift.dart';

import 'package:qibla_and_prayer_times/data/services/database/table/notification_settings_table.dart';
import 'package:qibla_and_prayer_times/data/services/database/table/juristic_method_table.dart';
import 'package:qibla_and_prayer_times/data/services/database_loader.dart';
import 'package:qibla_and_prayer_times/data/services/database/table/prayer_tracker_table.dart';
part 'prayer_database.g.dart';

@DriftDatabase(tables: [
  NotificationSettingsTable,
  JuristicMethodTable,
  PrayerTrackerTable
])
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

  Future<void> insertOrUpdatePrayerTrackerData(
      DateTime date, String trackerData) async {
    final existingEntry = await (select(prayerTrackerTable)
          ..where((tbl) => tbl.date.equals(date)))
        .getSingleOrNull();

    if (existingEntry != null) {
      await update(prayerTrackerTable).replace(existingEntry.copyWith(
          trackerData: trackerData, updatedAt: DateTime.now()));
    } else {
      await into(prayerTrackerTable).insert(
        PrayerTrackerTableCompanion.insert(
          date: date,
          trackerData: trackerData,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }
  }

  Future<String?> getPrayerTrackerData(DateTime date) async {
    final result = await (select(prayerTrackerTable)
          ..where((tbl) => tbl.date.equals(date)))
        .getSingleOrNull();

    return result?.trackerData;
  }
}
