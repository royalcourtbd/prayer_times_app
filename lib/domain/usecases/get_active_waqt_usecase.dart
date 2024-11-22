// lib/domain/usecases/get_active_waqt_usecase.dart

import 'package:fpdart/fpdart.dart';
import '../entities/prayer_time_entity.dart';
import '../service/waqt_calculation_service.dart';
import '../service/error_message_handler.dart';
import '../../core/base/base_use_case.dart';
import '../../presentation/prayer_time/models/waqt.dart';

class GetActiveWaqtUseCase
    extends BaseUseCase<({WaqtType activeWaqt, WaqtType nextWaqt})> {
  final WaqtCalculationService _waqtService;

  GetActiveWaqtUseCase(
    this._waqtService,
    ErrorMessageHandler errorMessageHandler,
  ) : super(errorMessageHandler);

  Future<Either<String, ({WaqtType activeWaqt, WaqtType nextWaqt})>> execute({
    required PrayerTimeEntity prayerTime,
    required DateTime currentTime,
  }) async {
    return mapResultToEither(() {
      final result = _waqtService.calculateActiveWaqt(
        prayerTime: prayerTime,
        currentTime: currentTime,
      );

      return result.fold(
        (error) => throw Exception(error),
        (success) => success,
      );
    });
  }
}
