import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/main/ui/main_page.dart';
import 'package:qibla_and_prayer_times/presentation/onboarding/presenter/onboarding_ui_state.dart';

class OnboardingPresenter extends BasePresenter<OnboardingUiState> {
  final Obs<OnboardingUiState> uiState = Obs(OnboardingUiState.empty());
  OnboardingUiState get currentUiState => uiState.value;
  final MainPresenter mainPresenter = locate<MainPresenter>();

  final PageController pageController = PageController();

  void onPageChanged({required int page}) {
    uiState.value = currentUiState.copyWith(currentPage: page);
  }

  void onSkipTap() {
    Future.microtask(() {
      currentUiState.context!.navigatorPushReplacement(MainPage());
    });
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

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onLocationAccessTap() async {
    // Handle location permission
    // Navigate to home page
    Future.microtask(() {
      currentUiState.context!.navigatorPushReplacement(MainPage());
    });
  }

  void onManualLocationTap() {
    // Navigate to location selection page
    Future.microtask(() {
      currentUiState.context!.navigatorPushReplacement(MainPage());
    });
  }
}
