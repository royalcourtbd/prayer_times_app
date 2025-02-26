import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';

class EventUiState extends BaseUiState {
  const EventUiState({
    required super.isLoading,
    required super.userMessage,
  });

  factory EventUiState.empty() {
    return const EventUiState(
      isLoading: false,
      userMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
      ];

  EventUiState copyWith({
    bool? isLoading,
    String? userMessage,
  }) {
    return EventUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }
}
