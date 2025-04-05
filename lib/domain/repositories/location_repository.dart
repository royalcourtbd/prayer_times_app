import 'package:fpdart/fpdart.dart';
import 'package:prayer_times/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<Either<String, LocationEntity>> getLocation(
      {bool forceRemote = false});
}
