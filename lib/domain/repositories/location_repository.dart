import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<Either<String, LocationEntity>> getLocation(
      {bool forceRemote = false});
}
