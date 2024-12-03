import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/domain/repositories/juristic_method_repository.dart';

class UpdateJuristicMethodUseCase {
  final JuristicMethodRepository _repository;

  UpdateJuristicMethodUseCase(this._repository);

  Future<Either<String, void>> execute({required String method}) async {
    return await _repository.updateJuristicMethod(method);
  }
}
