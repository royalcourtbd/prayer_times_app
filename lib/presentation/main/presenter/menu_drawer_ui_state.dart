import 'package:prayer_times/core/base/base_ui_state.dart';

class MenuDrawerUiState extends BaseUiState {
  const MenuDrawerUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory MenuDrawerUiState.empty() {
    return const MenuDrawerUiState(
      isLoading: false,
      userMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
      ];

  MenuDrawerUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return MenuDrawerUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
