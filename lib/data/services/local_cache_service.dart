import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qibla_and_prayer_times/core/utility/logger_utility.dart';
import 'package:qibla_and_prayer_times/core/utility/trial_utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/location_entity.dart';

const String _secretVaultName = "local_cache";

class LocalCacheService {
  static Future<void> setUp() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String documentPath = directory.path;
    Hive
      ..init(documentPath)
      ..registerAdapter(LocationEntityAdapter());

    if (!Hive.isBoxOpen(_storageFileName)) {
      await Hive.openBox<dynamic>(_storageFileName);
    }
  }

  static String get _storageFileName => '${_secretVaultName}_239090';
  late final Box<dynamic> _hiveBox = Hive.box(_storageFileName);

  /// Saves the provided `value` to the persistent storage using the specified `key`.
  ///
  /// The type parameter `T` represents the type of the `value` being saved,
  /// and it must be a subtype of `Object`.
  ///
  ///
  /// Example usage:
  ///
  /// ```dart
  /// await saveData(key: CacheKeys.userId, value: 'Sayed_vai_08');
  /// ```

  Future<void> saveData<T>({
    required String key,
    required T value,
  }) async {
    await catchFutureOrVoid(() async {
      if (key.isEmpty) return;
      await _hiveBox.put(key, value);
    });
  }

  /// Retrieves data from persistent storage using the specified `key`.
  ///
  /// The type parameter `T` represents the type of the data being retrieved,
  /// and it allows writing type-safe and reusable code that can operate on
  /// different data types.
  ///
  ///
  /// If an error occurs during the retrieval process, an error message is logged,
  /// and `null` is returned.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// String? userId = getData<String>(key: CacheKeys.userId);
  /// bool? isFirstTime = getData<bool>(key: CacheKeys.firstTime);
  /// ```
  ///
  /// Note: This function assumes that the `_hiveBox` instance is properly initialized
  /// and accessible within the scope of this function.
  T? getData<T>({required String key}) {
    try {
      final dynamic result = _hiveBox.get(key);
      if (result is T) {
        return result;
      }
      return null;
    } catch (e) {
      logError("getData: key: $key\nerror: $e");
      return null;
    }
  }

  /// Deletes data from persistent storage for the specified `key`.
  ///
  /// If the `key` does not exist, the operation completes without any effect.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// await deleteData(key: CacheKeys.userId);
  /// ```
  Future<void> deleteData({required String key}) async {
    await catchFutureOrVoid(() async {
      if (key.isEmpty) return;
      await _hiveBox.delete(key);
    });
  }
}

/// Utility class that provides constant values for cache keys used in the application.
///
///
/// Example usage:
///
/// ```dart
/// String userIdKey = CacheKeys.userId;
/// String fcmDeviceTokenKey = CacheKeys.fcmDeviceToken;
/// ```
///
/// Rationale:
///
/// - Avoids hardcoding cache keys as strings in different parts of the codebase,
///   reducing the likelihood of typos or inconsistencies.
/// - Improves code readability and maintainability by providing a single source
///   of truth for cache keys.
/// - Facilitates easy modification or updating of cache keys, as changes only
///   need to be made in one place.
///
/// Recommended to use these cache keys when interacting with the cache
/// to ensure consistency and reduce the risk of errors related to cache key usage.
class CacheKeys {
  CacheKeys._();

  static const String userId = 'userId_key';
  static const String fcmDeviceToken = "fcm_device_token_key";
  static const String lastSyncDate = "last_sync_date_key";
  static const String firstTime = "first_time_key";
  static const String launchCount = "launch_count_key";
  static const String location = "location_key";
}
