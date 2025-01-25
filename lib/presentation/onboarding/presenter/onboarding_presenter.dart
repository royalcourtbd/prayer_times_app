import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/throttle_service.dart';
import 'package:qibla_and_prayer_times/core/utility/number_utility.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/usecases/determine_first_run_use_case.dart';
import 'package:qibla_and_prayer_times/domain/usecases/save_first_time_use_case.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/main/ui/main_page.dart';
import 'package:qibla_and_prayer_times/presentation/onboarding/presenter/onboarding_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_presenter.dart';

class OnboardingPresenter extends BasePresenter<OnboardingUiState> {
  final DetermineFirstRunUseCase _determineFirstRunUseCase;
  final SaveFirstTimeUseCase _saveFirstTimeUseCase;

  OnboardingPresenter(
    this._determineFirstRunUseCase,
    this._saveFirstTimeUseCase,
  );

  final Obs<OnboardingUiState> uiState = Obs(OnboardingUiState.empty());
  OnboardingUiState get currentUiState => uiState.value;
  final MainPresenter mainPresenter = locate<MainPresenter>();
  final PrayerTimePresenter prayerTimePresenter = locate<PrayerTimePresenter>();

  final PageController pageController = PageController();

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> fetchAndListenToData(BuildContext context) async {
    await Future<void>.delayed(580.inMilliseconds);
    final bool isFirstTime = await determineIfFirstTime();
    if (!isFirstTime && context.mounted) goToHomePage(context);
  }

  Future<void> goToHomePage(BuildContext context) async {
    Throttle.throttle(
      "go_to_home_throttle",
      1.inSeconds,
      () async {
        final MainPage mainPage = await Future.microtask(() => MainPage());

        if (context.mounted) {
          await context.navigatorPushReplacement(mainPage);
        }
      },
    );
  }

  Future<bool> determineIfFirstTime() async {
    await toggleLoading(loading: true);
    final bool isFirstTime = await _determineFirstRunUseCase.execute();
    uiState.value = uiState.value.copyWith(isFirstTime: isFirstTime);
    await toggleLoading(loading: false);
    return isFirstTime;
  }

  Future<void> doneWithFirstTime() async {
    await toggleLoading(loading: true);
    await _saveFirstTimeUseCase.execute();
    uiState.value = uiState.value.copyWith(isFirstTime: false);
    await toggleLoading(loading: false);
  }

  void onPageChanged({required int page}) {
    uiState.value = currentUiState.copyWith(currentPage: page);
  }

  void onSkipTap() {
    // Animate to the last page
    pageController.animateToPage(
      onboardingPages.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void onNextTap() {
    if (currentUiState.currentPage < onboardingPages.length - 1) {
      final int nextPage = currentUiState.currentPage + 1;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      uiState.value = currentUiState.copyWith(
        currentPage: nextPage,
      );
    }
  }

  void onLocationAccessTap() async {
    try {
      await toggleLoading(loading: true);

      // First check internet connection
      bool isConnected = await checkInternetConnection();
      if (!isConnected) {
        await toggleLoading(loading: false);
        await addUserMessage('No Internet Connection');
        return;
      }

      // First check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await toggleLoading(loading: false);
        await addUserMessage('Please enable location services to continue');
        bool openSettings = await Geolocator.openLocationSettings();
        if (!openSettings) {
          await addUserMessage('Failed to open location settings');
        }
        return;
      }

      // If service is enabled, proceed with location access
      await prayerTimePresenter.loadLocationAndPrayerTimes();
      await addUserMessage('Location access granted');
      await toggleLoading(loading: false);

      Future.microtask(() async {
        currentUiState.context!.navigatorPushReplacement(MainPage());
        await doneWithFirstTime();
      });
    } catch (error) {
      await toggleLoading(loading: false);
      if (currentUiState.context != null && currentUiState.context!.mounted) {
        await addUserMessage(error.toString());

        if (error.toString().contains('Location permissions are denied')) {
          bool openSettings = await Geolocator.openLocationSettings();
          if (!openSettings) {
            await addUserMessage('Failed to open location settings');
          }
        }

        if (error.toString().contains('Permanently denied')) {
          bool openSettings = await Geolocator.openLocationSettings();
          if (!openSettings) {
            await addUserMessage('Failed to open location settings');
          }
        }
      }
    }
  }

  void onManualLocationTap() {
    Future.microtask(() async {
      currentUiState.context!.navigatorPushReplacement(MainPage());
      await doneWithFirstTime();
    });
  }

  void updateContext(BuildContext context) {
    uiState.value = currentUiState.copyWith(context: context);
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
}
