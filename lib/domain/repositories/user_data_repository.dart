abstract class UserDataRepository {
  Future<void> doneFirstTime();
  Future<bool> determineFirstRun();
}
