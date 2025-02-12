import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/static/constants.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/profile/presenter/profile_page_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/settings/ui/settings_page.dart';

class ProfilePagePresenter extends BasePresenter<ProfilePageUiState> {
  final Obs<ProfilePageUiState> uiState = Obs(ProfilePageUiState.empty());
  ProfilePageUiState get currentUiState => uiState.value;

  Future<void> onShareAppTap() async {
    await shareText(text: playStoreUrl);
  }

  Future<void> onSettingsTap() async {
    currentUiState.context!.navigatorPush(SettingsPage());
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
