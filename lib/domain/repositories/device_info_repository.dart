import 'package:fpdart/fpdart.dart';
import 'package:prayer_times/domain/entities/device_info_entity.dart';

abstract class DeviceInfoRepository {
  /// ডিভাইস তথ্য রেজিস্টার করা
  Future<void> registerDevice();

  /// সব ডিভাইসের তথ্য পেতে
  Stream<Either<String, List<DeviceInfoEntity>>> getAllRegisteredDevices();
}
