import 'package:hijri/hijri_calendar.dart';
import 'package:salat_times/core/base/base_presenter.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/domain/entities/location_entity.dart';
import 'package:salat_times/domain/entities/prayer_time_entity.dart';
import 'package:salat_times/domain/entities/ramadan_day_entity.dart';
import 'package:salat_times/domain/usecases/get_location_usecase.dart';
import 'package:salat_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:salat_times/presentation/event/pesenter/ramadan_calendar_ui_state.dart';
import 'package:intl/intl.dart';

class RamadanCalendarPresenter extends BasePresenter<RamadanCalendarUiState> {
  final GetPrayerTimesUseCase _getPrayerTimesUseCase;
  final GetLocationUseCase _getLocationUseCase;

  RamadanCalendarPresenter(
    this._getPrayerTimesUseCase,
    this._getLocationUseCase,
  );

  final Obs<RamadanCalendarUiState> uiState =
      Obs(RamadanCalendarUiState.empty());
  RamadanCalendarUiState get currentUiState => uiState.value;

  // Adjusted Ramadan 2025 start date - this can be updated based on actual moon sighting
  // For now, adjusting to one day later to fix the current day issue (showing 6 when it should be 5)
  final DateTime _ramadanStartDate = DateTime(2025, 3, 2);

  // Correction offset - this can be adjusted if needed based on local moon sighting decisions
  // Positive value means Ramadan starts later than calculated date
  // Negative value means Ramadan starts earlier than calculated date
  final int _moonSightingOffset = 0;

  // Calculate current Ramadan day based on today's date with adjustment for moon sighting
  int getCurrentRamadanDay() {
    final DateTime now = DateTime.now();

    // If current date is before Ramadan
    if (now.isBefore(_ramadanStartDate)) {
      return -1; // Ramadan hasn't started
    }

    // If current date is after Ramadan
    final DateTime ramadanEndDate = _ramadanStartDate.add(Duration(days: 29));
    if (now.isAfter(ramadanEndDate)) {
      return 31; // Ramadan has ended
    }

    // Calculate which day of Ramadan with adjustment for moon sighting
    return now.difference(_ramadanStartDate).inDays + 1 - _moonSightingOffset;
  }

  @override
  void onInit() {
    super.onInit();
    loadRamadanCalendar();
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(message: currentUiState.userMessage);
  }

  Future<void> loadRamadanCalendar() async {
    await executeTaskWithLoading(() async {
      await parseDataFromEitherWithUserMessage<LocationEntity>(
        task: () => _getLocationUseCase.execute(forceRemote: false),
        onDataLoaded: (LocationEntity location) async {
          final calendarData = await _generateRamadanCalendarData(location);
          uiState.value = currentUiState.copyWith(
            ramadanCalendar: calendarData,
            location: location,
            currentRamadanDay: getCurrentRamadanDay(),
          );
        },
      );
    });
  }

  /// Generate data for 30 days of Ramadan
  Future<List<RamadanDayEntity>> _generateRamadanCalendarData(
      LocationEntity location) async {
    List<RamadanDayEntity> calendarData = [];

    DateTime startDate = _ramadanStartDate;

    // Generate 30 days of Ramadan calendar
    for (int i = 0; i < 30; i++) {
      final currentDate = startDate.add(Duration(days: i));
      final prayerTime = await _getPrayerTime(currentDate, location);

      if (prayerTime == null) {
        continue;
      }

      // Calculate Hijri date
      final hijriDate = HijriCalendar.fromDate(currentDate);

      // Adjusted Ramadan day number to account for moon sighting correction
      final ramadanDay = (i + 1 - _moonSightingOffset).toString();

      // Sehri time (start of Fajr)
      final sehriTime = getFormattedTime(prayerTime.startFajr);

      // Iftar time (start of Maghrib)
      final iftarTime = getFormattedTime(prayerTime.startMaghrib);

      // Format date in English
      final formattedDate = _formatDateInEnglish(currentDate);

      // Weekday in English
      final weekdayInEnglish = _getWeekdayInEnglish(currentDate.weekday);

      // Hijri date in English
      final hijriDateInEnglish = '${hijriDate.hDay} Ramadan';

      calendarData.add(RamadanDayEntity(
        day: ramadanDay,
        date: formattedDate,
        weekday: weekdayInEnglish,
        hijriDate: hijriDateInEnglish,
        sehriTime: sehriTime,
        iftarTime: iftarTime,
      ));
    }

    return calendarData;
  }

  /// Get prayer time for specific date and location
  Future<PrayerTimeEntity?> _getPrayerTime(
      DateTime date, LocationEntity location) async {
    try {
      final result = await _getPrayerTimesUseCase.execute(
        latitude: location.latitude,
        longitude: location.longitude,
        date: date,
      );

      return result.fold(
        (error) => null,
        (prayerTime) => prayerTime,
      );
    } catch (e) {
      return null;
    }
  }

  /// Format date in English
  String _formatDateInEnglish(DateTime date) {
    // Example: 1 March
    final DateFormat formatter = DateFormat('d MMM');
    return formatter.format(date);
  }

  /// Get English weekday name
  String _getWeekdayInEnglish(int weekday) {
    const Map<int, String> englishWeekdays = {
      1: 'Mon',
      2: 'Tue',
      3: 'Wed',
      4: 'Thu',
      5: 'Fri',
      6: 'Sat',
      7: 'Sun',
    };

    return englishWeekdays[weekday] ?? '';
  }
}
