import 'package:drift/drift.dart';

class NotificationSettingsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();
}
