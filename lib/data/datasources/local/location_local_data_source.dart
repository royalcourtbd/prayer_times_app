import 'package:qibla_and_prayer_times/data/services/local_cache_service.dart';
import 'package:qibla_and_prayer_times/domain/entities/location_entity.dart';

abstract class LocationLocalDataSource {
  Future<LocationEntity?> getCachedLocation();
  Future<void> cacheLocation(LocationEntity location);
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  final LocalCacheService _localCacheService;

  LocationLocalDataSourceImpl(this._localCacheService);

  @override
  Future<void> cacheLocation(LocationEntity location) async {
    await _localCacheService.saveData(
      key: CacheKeys.location,
      value: location,
    );
  }

  @override
  Future<LocationEntity?> getCachedLocation() async {
    final LocationEntity? cachedLocation =
        _localCacheService.getData(key: CacheKeys.location);
    if (cachedLocation == null) {
      return null;
    }
    return LocationEntity(
      latitude: cachedLocation.latitude,
      longitude: cachedLocation.longitude,
      placeName: cachedLocation.placeName,
    );
  }
}
