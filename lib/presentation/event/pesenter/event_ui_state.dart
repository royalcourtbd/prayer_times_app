import 'package:salat_times/core/base/base_ui_state.dart';
import 'package:salat_times/presentation/event/pesenter/event_presenter.dart';

class EventUiState extends BaseUiState {
  final String searchQuery;
  final Map<String, List<EventModel>> groupedEvents;

  const EventUiState({
    required super.isLoading,
    required super.userMessage,
    required this.searchQuery,
    required this.groupedEvents,
  });

  factory EventUiState.empty() {
    return const EventUiState(
      isLoading: false,
      userMessage: '',
      searchQuery: '',
      groupedEvents: {},
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        searchQuery,
        groupedEvents,
      ];

  EventUiState copyWith({
    bool? isLoading,
    String? userMessage,
    String? searchQuery,
    Map<String, List<EventModel>>? groupedEvents,
  }) {
    return EventUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      groupedEvents: groupedEvents ?? this.groupedEvents,
    );
  }
}
