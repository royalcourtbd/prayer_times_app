import 'package:drift/drift.dart';

class JuristicMethodTable extends Table {
  TextColumn get method => text()();
  DateTimeColumn get updatedAt => dateTime()();
}
