// lib/domain/usecases/get_remaining_time_usecase.dart

import 'package:fpdart/fpdart.dart';
import '../service/waqt_calculation_service.dart';
import '../service/error_message_handler.dart';
import '../../core/base/base_use_case.dart';

class GetRemainingTimeUseCase extends BaseUseCase<
    ({Duration remainingDuration, Duration totalDuration, double progress})> {
  final WaqtCalculationService _waqtService;

  GetRemainingTimeUseCase(
    this._waqtService,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<
      Either<
          String,
          ({
            Duration remainingDuration,
            Duration totalDuration,
            double progress,
          })>> execute({
    required DateTime currentWaqtTime,
    required DateTime nextWaqtTime,
    required DateTime currentTime,
  }) async {
    return mapResultToEither(() {
      final result = _waqtService.calculateRemainingTime(
        currentWaqtTime: currentWaqtTime,
        nextWaqtTime: nextWaqtTime,
        currentTime: currentTime,
      );

      return result.fold(
        (error) => throw Exception(error),
        (success) => success,
      );
    });
  }
}
