import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';
import 'package:qibla_and_prayer_times/domain/service/time_service.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';

class GetActiveWaqtUseCase {
  final TimeService _timeService;
  final ErrorMessageHandler _errorHandler;

  const GetActiveWaqtUseCase(this._timeService, this._errorHandler);

  Future<Either<String, ({WaqtType activeWaqt, WaqtType nextWaqt})>> execute({
    required PrayerTimeEntity prayerTime,
  }) async {
    try {
      final DateTime now = _timeService.getCurrentTime();
      WaqtType? activeType;
      WaqtType? nextType;

      final List<MapEntry<WaqtType, DateTime>> prayers = [];

      // Add today's prayers
      prayers.addAll(_getTodaysPrayers(prayerTime));

      // Add tomorrow's Fajr
      final DateTime tomorrowFajr =
          prayerTime.startFajr.add(const Duration(days: 1));
      prayers.add(MapEntry(WaqtType.fajr, tomorrowFajr));

      // Sort prayers by time
      prayers.sort((a, b) => a.value.compareTo(b.value));

      // Find current and next prayer
      for (int i = 0; i < prayers.length; i++) {
        if (now.isBefore(prayers[i].value)) {
          activeType = i > 0 ? prayers[i - 1].key : prayers.last.key;
          nextType = prayers[i].key;
          break;
        }
      }

      if (activeType == null || nextType == null) {
        return left(_errorHandler.generateErrorMessage('Invalid prayer times'));
      }

      return right((activeWaqt: activeType, nextWaqt: nextType));
    } catch (e) {
      return left(_errorHandler.generateErrorMessage(e));
    }
  }

  List<MapEntry<WaqtType, DateTime>> _getTodaysPrayers(
    PrayerTimeEntity prayerTime,
  ) {
    return [
      MapEntry(WaqtType.fajr, prayerTime.startFajr),
      MapEntry(WaqtType.dhuhr, prayerTime.startDhuhr),
      MapEntry(WaqtType.asr, prayerTime.startAsr),
      MapEntry(WaqtType.maghrib, prayerTime.startMaghrib),
      MapEntry(WaqtType.isha, prayerTime.startIsha),
    ];
  }
}
