import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/utility/logger_utility.dart';
import 'package:qibla_and_prayer_times/data/datasources/remote/device_info_remote_data_source.dart';
import 'package:qibla_and_prayer_times/domain/entities/device_info_entity.dart';
import 'package:qibla_and_prayer_times/domain/repositories/device_info_repository.dart';

class DeviceInfoRepositoryImpl extends DeviceInfoRepository {
  DeviceInfoRepositoryImpl(this._deviceInfoRemoteDataSource);
  final DeviceInfoRemoteDataSource _deviceInfoRemoteDataSource;

  @override
  Future<void> registerDeviceToken(String token) async {
    // TODO: implement registerDeviceToken
  }

  @override
  Stream<Either<String, List<DeviceInfoEntity>>> getAllRegisteredDevices() {
    return _deviceInfoRemoteDataSource
        .getAllRegisteredDevices()
        .map((devices) => right<String, List<DeviceInfoEntity>>(devices))
        .handleError((error) {
      logError('Error getting all registered devices: $error');
      return left(error.toString());
    });
  }
}
