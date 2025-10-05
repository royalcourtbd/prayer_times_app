import 'package:fpdart/fpdart.dart';
import 'package:salat_times/data/services/database/prayer_database.dart';
import 'package:salat_times/domain/repositories/juristic_method_repository.dart';

class JuristicMethodRepositoryImpl implements JuristicMethodRepository {
  final PrayerDatabase _database;

  JuristicMethodRepositoryImpl(this._database);

  @override
  Future<Either<String, String>> getJuristicMethod() async {
    try {
      final String method = await _database.getJuristicMethod();
      return right(method);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updateJuristicMethod(String method) async {
    try {
      await _database.updateJuristicMethod(method);
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }
}
