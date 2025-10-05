import 'package:salat_times/core/base/base_ui_state.dart';

class MainUiState extends BaseUiState {
  const MainUiState({
    required super.isLoading,
    required super.userMessage,
    required this.selectedBottomNavIndex,
    this.lastBackPressTime,
  });

  factory MainUiState.empty() {
    return MainUiState(
      isLoading: false,
      userMessage: '',
      selectedBottomNavIndex: 0,
      lastBackPressTime: DateTime.now(),
    );
  }

  final int selectedBottomNavIndex;
  final DateTime? lastBackPressTime;

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        selectedBottomNavIndex,
        lastBackPressTime,
        lastBackPressTime,
      ];

  MainUiState copyWith({
    bool? isLoading,
    String? userMessage,
    int? selectedBottomNavIndex,
    DateTime? lastBackPressTime,
  }) {
    return MainUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      selectedBottomNavIndex:
          selectedBottomNavIndex ?? this.selectedBottomNavIndex,
      lastBackPressTime: lastBackPressTime ?? this.lastBackPressTime,
    );
  }
}
