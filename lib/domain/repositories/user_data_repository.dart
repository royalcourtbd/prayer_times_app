import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/domain/entities/app_update_entity.dart';

abstract class UserDataRepository {
  Future<void> doneFirstTime();
  Future<bool> determineFirstRun();
  Future<Either<String, AppUpdateEntity>> getAppUpdateInfo();
}
