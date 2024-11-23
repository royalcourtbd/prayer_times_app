import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';

class MainUiState extends BaseUiState {
  const MainUiState({
    required super.isLoading,
    required super.userMessage,
    required this.selectedBottomNavIndex,
    this.context,
    this.lastBackPressTime,
  });

  factory MainUiState.empty() {
    return MainUiState(
      isLoading: false,
      userMessage: '',
      selectedBottomNavIndex: 4,
      context: null,
      lastBackPressTime: DateTime.now(),
    );
  }

  final int selectedBottomNavIndex;
  final BuildContext? context;
  final DateTime? lastBackPressTime;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        selectedBottomNavIndex,
        context,
        lastBackPressTime,
      ];

  MainUiState copyWith({
    bool? isLoading,
    String? userMessage,
    int? selectedBottomNavIndex,
    BuildContext? context,
    DateTime? lastBackPressTime,
  }) {
    return MainUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      selectedBottomNavIndex:
          selectedBottomNavIndex ?? this.selectedBottomNavIndex,
      context: context ?? this.context,
      lastBackPressTime: lastBackPressTime ?? this.lastBackPressTime,
    );
  }
}
