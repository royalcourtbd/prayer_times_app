import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_juristic_method_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/update_juristic_method_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/settings/presenter/settings_page_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/settings/widgets/juristic_method_bottom_sheet.dart';

class SettingsPagePresenter extends BasePresenter<SettingsPageUiState> {
  final GetJuristicMethodUseCase _getJuristicMethodUseCase;
  final UpdateJuristicMethodUseCase _updateJuristicMethodUseCase;

  SettingsPagePresenter(
    this._getJuristicMethodUseCase,
    this._updateJuristicMethodUseCase,
  );

  final PrayerTimePresenter _prayerTimePresenter =
      locate<PrayerTimePresenter>();

  final Obs<SettingsPageUiState> uiState = Obs(SettingsPageUiState.empty());
  SettingsPageUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    _loadJuristicMethod();
    super.onInit();
  }

  Future<void> _loadJuristicMethod() async {
    await executeTaskWithLoading(() async {
      await parseDataFromEitherWithUserMessage(
        task: () => _getJuristicMethodUseCase.execute(),
        onDataLoaded: (String method) {
          if (method.isNotEmpty) {
            uiState.value =
                currentUiState.copyWith(selectedJuristicMethod: method);
          }
        },
      );
    });
  }

  Future<void> onJuristicMethodChanged({required String method}) async {
    await executeTaskWithLoading(() async {
      await parseDataFromEitherWithUserMessage(
        task: () => _updateJuristicMethodUseCase.execute(method: method),
        onDataLoaded: (_) async {
          uiState.value =
              currentUiState.copyWith(selectedJuristicMethod: method);
          await _prayerTimePresenter.getPrayerTimes();
        },
      );
    });
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
