import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/animate_do/slides.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_button.dart';
import 'package:qibla_and_prayer_times/presentation/onboarding/presenter/onboarding_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/onboarding/presenter/onboarding_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/onboarding/widgets/onboarding_content_widget.dart';
import 'package:qibla_and_prayer_times/presentation/onboarding/widgets/skip_button_widget.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final OnboardingPresenter _presenter = locate<OnboardingPresenter>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    _presenter.updateContext(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return PresentableWidgetBuilder(
      presenter: _presenter,
      onInit: () => _presenter.fetchAndListenToData(context),
      builder: () {
        final currentUiState = _presenter.currentUiState;

        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _presenter.pageController,
                      onPageChanged: (page) =>
                          _presenter.onPageChanged(page: page),
                      itemCount: onboardingPages.length,
                      itemBuilder: (context, index) => OnboardingContentWidget(
                        content: onboardingPages[index],
                        theme: theme,
                      ),
                    ),
                  ),
                  if (currentUiState.currentPage < 2) ...[
                    SlideInUp(
                      duration: const Duration(milliseconds: 400),
                      child: CustomButton(
                        title: 'Continue',
                        onPressed: _presenter.onNextTap,
                      ),
                    ),
                    gapH20,
                  ] else ...[
                    SlideInUp(
                      duration: const Duration(milliseconds: 400),
                      child: CustomButton(
                        title: 'Allow Location Access',
                        onPressed: _presenter.onLocationAccessTap,
                      ),
                    ),
                    // gapH20,
                    // SlideInUp(
                    //   duration: const Duration(milliseconds: 200),
                    //   child: CustomButton(
                    //     title: 'Select Location Manually',
                    //     isPrimary: false,
                    //     onPressed: _presenter.onManualLocationTap,
                    //   ),
                    // ),
                    gapH20,
                  ],
                ],
              ),
              if (currentUiState.currentPage < onboardingPages.length - 1) ...[
                SkipButtonWidget(
                  onTap: _presenter.onSkipTap,
                  theme: theme,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
