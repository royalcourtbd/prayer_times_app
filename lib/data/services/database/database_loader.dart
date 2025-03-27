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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:qibla_and_prayer_times/core/utility/logger_utility.dart';

const String _dbName = "prayer_tracker.db";

Future<void> loadEnv() async {
  try {
    await dotenv.load(fileName: '.env');
    logDebugStatic('Env file loaded successfully', 'DatabaseLoader');
  } catch (e) {
    logErrorStatic('Error loading .env file: $e', 'DatabaseLoader');
    throw Exception('Error loading .env file: $e');
  }
}

LazyDatabase loadDatabase() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, _dbName));
    return NativeDatabase.createInBackground(file);
  });
}
