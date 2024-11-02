import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_times_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_ui_state.dart';

class PrayerTimePresenter extends BasePresenter<PrayerTimeUiState> {
  final GetPrayerTimesUseCase _getPrayerTimesUseCase;

  PrayerTimePresenter(this._getPrayerTimesUseCase);
  final Obs<PrayerTimeUiState> uiState = Obs(PrayerTimeUiState.empty());

  PrayerTimeUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    super.onInit();
    getPrayerTimes();
  }

  List<WaqtViewModel> get waqtList {
    final prayerTime = currentUiState.prayerTime;
    final now = DateTime.now();

    return [
      WaqtViewModel(
        type: WaqtType.fajr,
        time: prayerTime?.fajr,
        isActive: _isCurrentWaqt(prayerTime?.fajr, prayerTime?.dhuhr, now),
      ),
      WaqtViewModel(
        type: WaqtType.dhuhr,
        time: prayerTime?.dhuhr,
        isActive: _isCurrentWaqt(prayerTime?.dhuhr, prayerTime?.asr, now),
      ),
      WaqtViewModel(
        type: WaqtType.asr,
        time: prayerTime?.asr,
        isActive: _isCurrentWaqt(prayerTime?.asr, prayerTime?.maghrib, now),
      ),
      WaqtViewModel(
        type: WaqtType.maghrib,
        time: prayerTime?.maghrib,
        isActive: _isCurrentWaqt(prayerTime?.maghrib, prayerTime?.isha, now),
      ),
      WaqtViewModel(
        type: WaqtType.isha,
        time: prayerTime?.isha,
        isActive: _isCurrentWaqt(prayerTime?.isha, prayerTime?.fajr, now),
      ),
    ];
  }

  bool _isCurrentWaqt(DateTime? start, DateTime? end, DateTime now) {
    if (start == null || end == null) return false;
    return now.isAfter(start) && now.isBefore(end);
  }

  WaqtViewModel? get currentWaqt {
    return waqtList.firstWhereOrNull((waqt) => waqt.isActive);
  }

  Future<void> getPrayerTimes() async {
    await executeTaskWithLoading(
      () async {
        await parseDataFromEitherWithUserMessage<PrayerTimeEntity>(
          task: () => _getPrayerTimesUseCase.execute(
            latitude: 23.8103,
            longitude: 90.4125,
          ),
          onDataLoaded: (data) {
            uiState.value = currentUiState.copyWith(prayerTime: data);
          },
        );
      },
    );
  }

  void toggleNotifyMe(bool value) {
    uiState.value = currentUiState.copyWith(notifyMe: value);
    addUserMessage('Notify me every prayer time: $value');
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(message: message, context: currentUiState.context);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  void updateContext(BuildContext context) {
    uiState.value = currentUiState.copyWith(context: context);
  }
}
