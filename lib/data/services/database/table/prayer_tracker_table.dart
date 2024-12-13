// lib/data/services/database/table/prayer_tracker_table.dart
import 'package:drift/drift.dart';

class PrayerTrackerTable extends Table {
  DateTimeColumn get date => dateTime()();
  TextColumn get trackerData => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {date};
}
