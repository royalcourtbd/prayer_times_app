import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qibla_and_prayer_times/data/datasources/local/location_local_data_source.dart';
import 'package:qibla_and_prayer_times/data/datasources/remote/location_remote_data_source.dart';
import 'package:qibla_and_prayer_times/data/models/location_model.dart';
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
      // First try to get cached location
      final LocationEntity? cachedLocation =
          await _localDataSource.getCachedLocation();
      if (cachedLocation != null) {
        log('location from cache');
        return right(cachedLocation);
      }

      // If no cache, try to get current location
      try {
        final Position position = await _locationService.getCurrentPosition();
        final LocationEntity location =
            await _remoteDataSource.getPlaceNameFromCoordinates(
                latitude: position.latitude, longitude: position.longitude);
        log('location from remote');
        await _localDataSource.cacheLocation(location);
        return right(location);
      } on Exception catch (locationError) {
        // If location service fails, check if we have cached data as fallback
        if (cachedLocation != null) {
          log('using cached location after location service error');
          return right(LocationModel.fromEntity(cachedLocation));
        }
        // If no cached data available, propagate the error
        if (locationError.toString().contains('UNAVAILABLE')) {
          return left(
              'Location services are currently unavailable. Please check your device settings.');
        }
        return left(locationError.toString());
      }
    } catch (e) {
      return left('Failed to get location: ${e.toString()}');
    }
  }
}
