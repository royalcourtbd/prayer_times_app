import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_ui_state.dart';

class PrayerTimePresenter extends BasePresenter<PrayerTimeUiState> {
  final Obs<PrayerTimeUiState> uiState = Obs(PrayerTimeUiState.empty());

  PrayerTimeUiState get currentUiState => uiState.value;

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
