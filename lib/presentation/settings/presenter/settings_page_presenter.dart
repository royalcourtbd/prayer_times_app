import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/settings/widgets/juristic_method_bottom_sheet.dart';

class SettingsPagePresenter extends BasePresenter<SettingsPageUiState> {
  final Obs<SettingsPageUiState> uiState = Obs(SettingsPageUiState.empty());
  SettingsPageUiState get currentUiState => uiState.value;

  void onJuristicMethodChanged({required String method}) {
    uiState.value = currentUiState.copyWith(selectedJuristicMethod: method);
  }

  void showJuristicMethodBottomSheet() {
    JuristicMethodBottomSheet.show(
      context: currentUiState.context!,
      presenter: this,
    );
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
}
