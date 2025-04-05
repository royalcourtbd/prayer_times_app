import 'package:fpdart/fpdart.dart';
import 'package:prayer_times/domain/repositories/juristic_method_repository.dart';

class GetJuristicMethodUseCase {
  final JuristicMethodRepository _repository;

  GetJuristicMethodUseCase(this._repository);

  Future<Either<String, String>> execute() async {
    return await _repository.getJuristicMethod();
  }
}
