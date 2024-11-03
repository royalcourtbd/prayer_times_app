import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';
import 'package:qibla_and_prayer_times/domain/service/time_service.dart';

class GetRemainingTimeUseCase {
  final TimeService _timeService;
  final ErrorMessageHandler _errorHandler;

  const GetRemainingTimeUseCase(this._timeService, this._errorHandler);

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
  }) async {
    try {
      final DateTime now = _timeService.getCurrentTime();

      // Handle case when next prayer is tomorrow
      DateTime adjustedNextWaqtTime = nextWaqtTime;
      if (nextWaqtTime.isBefore(now)) {
        adjustedNextWaqtTime = nextWaqtTime.add(const Duration(days: 1));
      }

      final Duration totalDuration =
          adjustedNextWaqtTime.difference(currentWaqtTime);
      final Duration remainingDuration = adjustedNextWaqtTime.difference(now);

      // Ensure remaining duration is never negative
      final Duration validRemainingDuration =
          remainingDuration.isNegative ? const Duration() : remainingDuration;

      // Calculate progress (100 means full, 0 means empty)
      final double progress =
          _calculateProgress(totalDuration, validRemainingDuration);

      return right((
        remainingDuration: validRemainingDuration,
        totalDuration: totalDuration,
        progress: progress,
      ));
    } catch (e) {
      return left(_errorHandler.generateErrorMessage(e));
    }
  }

  double _calculateProgress(Duration total, Duration remaining) {
    return ((total.inSeconds - remaining.inSeconds) / total.inSeconds * 100)
        .clamp(0, 100);
  }
}
