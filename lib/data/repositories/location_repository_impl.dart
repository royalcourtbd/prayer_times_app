import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qibla_and_prayer_times/data/datasources/local/location_local_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/remote/location_remote_data_source.dart';
import 'package:qibla_and_prayer_times/data/services/location_service.dart';
import 'package:qibla_and_prayer_times/domain/entities/location_entity.dart';
import 'package:qibla_and_prayer_times/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _remoteDataSource;
  final LocationLocalDataSource _localDataSource;
  final LocationService _locationService;

  LocationRepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._locationService);
  @override
  Future<Either<String, LocationEntity>> getLocation() async {
    try {
      final LocationEntity? cachedLocation =
          await _localDataSource.getCachedLocation();
      if (cachedLocation != null) {
        return right(cachedLocation);
      }
      final Position position = await _locationService.getCurrentPosition();
      final LocationEntity location =
          await _remoteDataSource.getPlaceNameFromCoordinates(
              latitude: position.latitude, longitude: position.longitude);
      await _localDataSource.cacheLocation(location);
      return right(location);
    } catch (e) {
      return left(e.toString());
    }
  }
}
