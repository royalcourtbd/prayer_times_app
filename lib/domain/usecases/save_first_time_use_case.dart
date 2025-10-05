import 'package:salat_times/core/base/base_use_case.dart';
import 'package:salat_times/domain/repositories/user_data_repository.dart';

class SaveFirstTimeUseCase extends BaseUseCase<void> {
  final UserDataRepository userDataRepository;

  SaveFirstTimeUseCase(
    super.errorMessageHandler,
    this.userDataRepository,
  );

  Future<void> execute() async {
    await doVoid(() => userDataRepository.doneFirstTime());
  }
}
