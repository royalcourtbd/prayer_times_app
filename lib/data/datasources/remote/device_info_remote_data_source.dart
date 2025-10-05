import 'package:salat_times/data/services/backend_as_a_service.dart';
import 'package:salat_times/domain/entities/device_info_entity.dart';

abstract class DeviceInfoRemoteDataSource {
  Future<void> registerDevice();
  Stream<List<DeviceInfoEntity>> getAllRegisteredDevices();
}

/// ডিভাইস তথ্য রিমোট ডাটাসোর্স

class DeviceInfoRemoteDataSourceImpl extends DeviceInfoRemoteDataSource {
  DeviceInfoRemoteDataSourceImpl(this._backendAsAService);
  final BackendAsAService _backendAsAService;

  @override
  Future<void> registerDevice() async {
    return _backendAsAService.registerDevice();
  }

  @override
  Stream<List<DeviceInfoEntity>> getAllRegisteredDevices() {
    return _backendAsAService.getAllRegisteredDevices();
  }
}
