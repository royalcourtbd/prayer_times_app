// lib/data/services/database/prayer_database.dart

import 'package:drift/drift.dart';
import 'package:qibla_and_prayer_times/data/services/database/table/prayer_tracker_table.dart';
import 'package:qibla_and_prayer_times/data/services/database_loader.dart';

part 'prayer_database.g.dart';

@DriftDatabase(tables: [PrayerTrackerTable])
class PrayerDatabase extends _$PrayerDatabase {
  PrayerDatabase({QueryExecutor? queryExecutor})
      : super(queryExecutor ?? loadDatabase());

  @override
  int get schemaVersion => 1;
}
