import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salat_times/data/datasources/local/location_local_data_source.dart';
import 'package:salat_times/data/datasources/remote/location_remote_data_source.dart';
import 'package:salat_times/data/services/location_service.dart';
import 'package:salat_times/domain/entities/location_entity.dart';
import 'package:salat_times/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _remoteDataSource;
  final LocationLocalDataSource _localDataSource;
  final LocationService _locationService;

  LocationRepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._locationService);

  @override
  Future<Either<String, LocationEntity>> getLocation(
      {bool forceRemote = false}) async {
    try {
      // যদি forceRemote true হয় তাহলে সরাসরি রিমোট থেকে ডাটা আনবে
      if (forceRemote) {
        return await _getRemoteLocation();
      }

      // প্রথমে ক্যাশড লোকেশন চেক করা
      final LocationEntity? cachedLocation =
          await _localDataSource.getCachedLocation();
      if (cachedLocation != null) {
        return right(cachedLocation);
      }

      // ক্যাশে না থাকলে রিমোট থেকে আনা
      return await _getRemoteLocation();
    } catch (e) {
      return left('Failed to get location: ${e.toString()}');
    }
  }

  // রিমোট থেকে লোকেশন আনার মেথড
  Future<Either<String, LocationEntity>> _getRemoteLocation() async {
    try {
      final Position position = await _locationService.getCurrentPosition();
      final LocationEntity location =
          await _remoteDataSource.getPlaceNameFromCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      log('location from remote');
      await _localDataSource.cacheLocation(location);
      return right(location);
    } on Exception catch (locationError) {
      if (locationError.toString().contains('UNAVAILABLE')) {
        return left(
            'Location services are currently unavailable. Please check your device settings.');
      }
      return left(locationError.toString());
    }
  }
}
