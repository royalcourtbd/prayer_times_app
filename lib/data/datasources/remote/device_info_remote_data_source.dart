import 'package:qibla_and_prayer_times/data/services/backend_as_a_service.dart';
import 'package:qibla_and_prayer_times/domain/entities/device_info_entity.dart';

abstract class DeviceInfoRemoteDataSource {
  Future<void> registerDeviceToken(String token);

  Stream<List<DeviceInfoEntity>> getAllRegisteredDevices();
}

class DeviceInfoRemoteDataSourceImpl extends DeviceInfoRemoteDataSource {
  DeviceInfoRemoteDataSourceImpl(this._backendAsAService);
  final BackendAsAService _backendAsAService;

  @override
  Future<void> registerDeviceToken(String token) async {
    // TODO: implement registerDeviceToken
  }

  @override
  Stream<List<DeviceInfoEntity>> getAllRegisteredDevices() {
    return _backendAsAService.getAllRegisteredDevices();
  }
}
