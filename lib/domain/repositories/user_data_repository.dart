import 'package:fpdart/fpdart.dart';
import 'package:prayer_times/domain/entities/app_update_entity.dart';

abstract class UserDataRepository {
  Future<void> doneFirstTime();
  Future<bool> determineFirstRun();
  Future<Either<String, AppUpdateEntity>> getAppUpdateInfo();
}
