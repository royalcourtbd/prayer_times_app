// // lib/data/services/database_loader.dart
// import 'dart:io';
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:path/path.dart' as p;
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';

// const String _dbName = "prayer_tracker.db";

// LazyDatabase loadDatabase() => LazyDatabase(() => _openConnection);

// Future<QueryExecutor> get _openConnection async {
//   final dbFolder = await path_provider.getApplicationDocumentsDirectory();
//   final file = File(p.join(dbFolder.path, _dbName));
//   return NativeDatabase.createInBackground(file);
// }

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

const String _dbName = "prayer_tracker.db";

LazyDatabase loadDatabase() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, _dbName));
    return NativeDatabase.createInBackground(file);
  });
}
