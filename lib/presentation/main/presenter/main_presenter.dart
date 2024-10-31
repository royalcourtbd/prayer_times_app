import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_ui_state.dart';

class MainPresenter extends BasePresenter<MainUiState> {
  final Obs<MainUiState> uiState = Obs(MainUiState.empty());

  MainUiState get currentState => uiState.value;

  void changeNavigationIndex(int index) {
    uiState.value = currentState.copyWith(selectedBottomNavIndex: index);
  }

  void updateContext(BuildContext context) {
    uiState.value = currentState.copyWith(context: context);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentState.copyWith(userMessage: message);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentState.copyWith(isLoading: loading);
  }
}
