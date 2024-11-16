import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_ui_state.dart';

class MainPresenter extends BasePresenter<MainUiState> {
  final Obs<MainUiState> uiState = Obs(MainUiState.empty());

  MainUiState get currentUiState => uiState.value;

  void changeNavigationIndex(int index) {
    uiState.value = currentUiState.copyWith(selectedBottomNavIndex: index);
  }

  Future<void> handleBackPress() async {
    if (currentUiState.selectedBottomNavIndex != 0) {
      changeNavigationIndex(0);
      return;
    }

    final DateTime now = DateTime.now();
    final DateTime lastPressed =
        currentUiState.lastBackPressTime ?? DateTime.now();

    if (now.difference(lastPressed) > const Duration(seconds: 2)) {
      updateLastBackPressTime(now);
      addUserMessage('Press back again to exit');
      return;
    }

    await SystemNavigator.pop();
  }

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

  void updateLastBackPressTime(DateTime time) {
    uiState.value = currentUiState.copyWith(lastBackPressTime: time);
  }
}
