import 'package:geocoding/geocoding.dart';
import 'package:qibla_and_prayer_times/domain/entities/location_entity.dart';

abstract class LocationRemoteDataSource {
  Future<LocationEntity> getPlaceNameFromCoordinates({
    required double latitude,
    required double longitude,
  });
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  @override
  Future<LocationEntity> getPlaceNameFromCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        final List<String> addressParts = [
          if (place.subLocality?.isNotEmpty == true) place.subLocality!,
          if (place.locality?.isNotEmpty == true) place.locality!,
          // if (place.country?.isNotEmpty == true) place.country!,
        ];

        return LocationEntity(
          latitude: latitude,
          longitude: longitude,
          placeName: addressParts.join(', '),
        );
      } else {
        return LocationEntity(latitude: latitude, longitude: longitude);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
