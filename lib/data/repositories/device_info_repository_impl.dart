import 'package:fpdart/fpdart.dart';
import 'package:salat_times/core/utility/logger_utility.dart';
import 'package:salat_times/core/utility/trial_utility.dart';
import 'package:salat_times/data/datasources/remote/device_info_remote_data_source.dart';
import 'package:salat_times/data/services/backend_as_a_service.dart';
import 'package:salat_times/data/services/local_cache_service.dart';
import 'package:salat_times/domain/entities/device_info_entity.dart';
import 'package:salat_times/domain/repositories/device_info_repository.dart';

class DeviceInfoRepositoryImpl extends DeviceInfoRepository {
  DeviceInfoRepositoryImpl(this._deviceInfoRemoteDataSource,
      this._backendAsAService, this._localCacheService);
  final DeviceInfoRemoteDataSource _deviceInfoRemoteDataSource;
  final BackendAsAService _backendAsAService;
  final LocalCacheService _localCacheService;

  Future<void> _getAndSaveDeviceToken() async {
    await catchAndReturnFuture(() async {
      await _backendAsAService.listenToDeviceToken(onTokenFound: (token) async {
        await _localCacheService.saveData(
          key: CacheKeys.fcmDeviceToken,
          value: token,
        );
      });
    });
  }

  @override
  Future<void> registerDevice() async {
    await _getAndSaveDeviceToken();
    return _deviceInfoRemoteDataSource.registerDevice();
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
