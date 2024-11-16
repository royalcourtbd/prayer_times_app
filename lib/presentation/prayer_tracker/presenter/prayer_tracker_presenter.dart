import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_ui_state.dart';

class PrayerTrackerPresenter extends BasePresenter<PrayerTrackerUiState> {
  final Obs<PrayerTrackerUiState> uiState = Obs(PrayerTrackerUiState.empty());
  PrayerTrackerUiState get currentUiState => uiState.value;

  void updateContext(BuildContext context) {
    uiState.value = currentUiState.copyWith(context: context);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(
        message: currentUiState.userMessage, context: currentUiState.context);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
