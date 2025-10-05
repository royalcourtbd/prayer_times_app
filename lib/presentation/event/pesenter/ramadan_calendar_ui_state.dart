import 'package:salat_times/core/base/base_ui_state.dart';
import 'package:salat_times/domain/entities/location_entity.dart';
import 'package:salat_times/domain/entities/ramadan_day_entity.dart';

class RamadanCalendarUiState extends BaseUiState {
  final List<RamadanDayEntity> ramadanCalendar;
  final LocationEntity? location;
  final int currentRamadanDay;

  const RamadanCalendarUiState({
    required this.ramadanCalendar,
    this.location,
    required this.currentRamadanDay,
    required super.isLoading,
    required super.userMessage,
  });

  factory RamadanCalendarUiState.empty() {
    return const RamadanCalendarUiState(
      ramadanCalendar: [],
      location: null,
      currentRamadanDay: -1,
      isLoading: false,
      userMessage: null,
    );
  }

  RamadanCalendarUiState copyWith({
    List<RamadanDayEntity>? ramadanCalendar,
    LocationEntity? location,
    int? currentRamadanDay,
    bool? isLoading,
    String? userMessage,
  }) {
    return RamadanCalendarUiState(
      ramadanCalendar: ramadanCalendar ?? this.ramadanCalendar,
      location: location ?? this.location,
      currentRamadanDay: currentRamadanDay ?? this.currentRamadanDay,
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, userMessage, ramadanCalendar, location, currentRamadanDay];
}
