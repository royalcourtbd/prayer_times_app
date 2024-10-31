import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';

class MainUiState extends BaseUiState {
  const MainUiState({
    required super.isLoading,
    required super.userMessage,
    required this.selectedBottomNavIndex,
    this.context,
  });

  factory MainUiState.empty() {
    return const MainUiState(
      isLoading: false,
      userMessage: '',
      selectedBottomNavIndex: 0,
      context: null,
    );
  }

  final int selectedBottomNavIndex;
  final BuildContext? context;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        selectedBottomNavIndex,
        context,
      ];

  MainUiState copyWith({
    bool? isLoading,
    String? userMessage,
    int? selectedBottomNavIndex,
    BuildContext? context,
  }) {
    return MainUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      selectedBottomNavIndex:
          selectedBottomNavIndex ?? this.selectedBottomNavIndex,
      context: context ?? this.context,
    );
  }
}
