import 'package:fpdart/fpdart.dart';

abstract class JuristicMethodRepository {
  Future<Either<String, String>> getJuristicMethod();
  Future<Either<String, void>> updateJuristicMethod(String method);
}
