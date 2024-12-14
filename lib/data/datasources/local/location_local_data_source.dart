import 'package:qibla_and_prayer_times/domain/entities/location_entity.dart';

abstract class LocationLocalDataSource {
  Future<LocationEntity?> getCachedLocation();
  Future<void> cacheLocation(LocationEntity location);
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  // Using in memory cache for simplicity, can be replaced with shared preferences, or sqlite
  LocationEntity? _cachedLocation;
  @override
  Future<void> cacheLocation(LocationEntity location) async {
    _cachedLocation = location;
  }

  @override
  Future<LocationEntity?> getCachedLocation() async {
    return _cachedLocation;
  }
}
