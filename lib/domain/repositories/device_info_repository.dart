import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/domain/entities/device_info_entity.dart';

abstract class DeviceInfoRepository {
  Future<void> registerDeviceToken(String token);
  Stream<Either<String, List<DeviceInfoEntity>>> getAllRegisteredDevices();
}
