// prayer_time_ui_state.dart
import 'package:flutter/widgets.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';

class ProfilePageUiState extends BaseUiState {
  const ProfilePageUiState({
    required super.isLoading,
    required super.userMessage,
    this.context,
  });

  final BuildContext? context;

  factory ProfilePageUiState.empty() {
    return const ProfilePageUiState(
      isLoading: false,
      userMessage: '',
      context: null,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        context,
      ];

  ProfilePageUiState copyWith({
    bool? isLoading,
    String? userMessage,
    BuildContext? context,
  }) {
    return ProfilePageUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      context: context ?? this.context,
    );
  }
}
