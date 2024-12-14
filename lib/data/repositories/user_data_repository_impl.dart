import 'package:qibla_and_prayer_times/core/utility/trial_utility.dart';
import 'package:qibla_and_prayer_times/data/datasources/local/user_data_local_data_source.dart';
import 'package:qibla_and_prayer_times/domain/repositories/user_data_repository.dart';

class UserDataRepositoryImpl extends UserDataRepository {
  UserDataRepositoryImpl(
    this._userDataLocalDataSource,
  );

  final UserDataLocalDataSource _userDataLocalDataSource;

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
}
