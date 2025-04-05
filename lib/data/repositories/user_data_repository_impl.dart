import 'package:fpdart/fpdart.dart';
import 'package:prayer_times/core/utility/trial_utility.dart';
import 'package:prayer_times/data/datasources/local/user_data_local_data_source.dart';
import 'package:prayer_times/data/models/app_update_model.dart';
import 'package:prayer_times/data/services/backend_as_a_service.dart';
import 'package:prayer_times/domain/entities/app_update_entity.dart';
import 'package:prayer_times/domain/repositories/user_data_repository.dart';

class UserDataRepositoryImpl extends UserDataRepository {
  UserDataRepositoryImpl(
    this._userDataLocalDataSource,
    this._backendService,
  );

  final UserDataLocalDataSource _userDataLocalDataSource;
  final BackendAsAService _backendService;

  @override
  Future<void> doneFirstTime() => _userDataLocalDataSource.doneFirstTime();

  @override
  Future<bool> determineFirstRun() async {
    final bool? shouldCountAsFirstTime = await catchAndReturnFuture(() async {
      final bool isFirstTime =
          await _userDataLocalDataSource.determineFirstRun();
      if (isFirstTime) return true;
      return false;
    });

    return shouldCountAsFirstTime ?? true;
  }

  @override
  Future<Either<String, AppUpdateEntity>> getAppUpdateInfo() async {
    try {
      final Map<String, dynamic> result =
          await _backendService.getAppUpdateInfo();
      return right(AppUpdateModel.fromJson(result));
    } catch (e) {
      return left(e.toString());
    }
  }
}
