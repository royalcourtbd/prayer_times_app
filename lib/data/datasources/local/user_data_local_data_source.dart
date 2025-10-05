import 'package:salat_times/data/services/local_cache_service.dart';

class UserDataLocalDataSource {
  UserDataLocalDataSource(
    this._localCacheService,
  );

  final LocalCacheService _localCacheService;

  Future<bool> determineFirstRun() async {
    final bool? firstTime = _localCacheService.getData(
      key: CacheKeys.firstTime,
    );
    return firstTime ?? true;
  }

  Future<void> doneFirstTime() async {
    await _localCacheService.saveData(key: CacheKeys.firstTime, value: false);
  }
}
