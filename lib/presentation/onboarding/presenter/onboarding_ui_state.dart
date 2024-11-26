import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/domain/entities/onboarding_content.dart';

class OnboardingUiState extends BaseUiState {
  const OnboardingUiState({
    required super.isLoading,
    required super.userMessage,
    required this.currentPage,
    this.context,
  });

  final int currentPage;
  final BuildContext? context;

  factory OnboardingUiState.empty() {
    return const OnboardingUiState(
      isLoading: false,
      userMessage: '',
      currentPage: 0,
      context: null,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        currentPage,
        context,
      ];

  OnboardingUiState copyWith({
    bool? isLoading,
    String? userMessage,
    int? currentPage,
    BuildContext? context,
  }) {
    return OnboardingUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      currentPage: currentPage ?? this.currentPage,
      context: context ?? this.context,
    );
  }
}

final List<OnboardingContent> onboardingPages = [
  const OnboardingContent(
    title: 'Accurate Salat Times, Anywhere',
    description:
        'Precise prayer times based on your location, with customizable reminders for every prayer.',
    image: SvgPath.icOnboarding1,
    index: 0,
  ),
  const OnboardingContent(
    title: 'Track Your Daily Prayers',
    description:
        'Keep track of your daily prayers and build consistency in your worship.',
    image: SvgPath.icOnboarding2,
    index: 1,
  ),
  const OnboardingContent(
    title: 'Enable Location for Prayer Times',
    description: 'Get accurate prayer times and Qibla direction',
    image: SvgPath.icOnboarding3,
    index: 2,
  ),
];
