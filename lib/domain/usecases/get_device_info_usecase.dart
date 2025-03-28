import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/base/base_use_case.dart';
import 'package:qibla_and_prayer_times/domain/entities/device_info_entity.dart';
import 'package:qibla_and_prayer_times/domain/repositories/device_info_repository.dart';
import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';

class GetDeviceInfoUsecase extends BaseUseCase<List<DeviceInfoEntity>> {
  final DeviceInfoRepository _deviceInfoRepository;

  GetDeviceInfoUsecase(
    this._deviceInfoRepository,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Stream<Either<String, List<DeviceInfoEntity>>> execute() {
    return _deviceInfoRepository.getAllRegisteredDevices();
  }
}
