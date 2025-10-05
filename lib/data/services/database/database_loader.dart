import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:salat_times/core/utility/logger_utility.dart';

const String _dbName = "prayer_tracker.db";

Future<void> loadEnv() async {
  try {
    await dotenv.load(fileName: '.env');
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
