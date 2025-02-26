// lib/presentation/prayer_tracker/models/calendar_date_cell_view_model.dart

class CalendarDateCellViewModel {
  final DateTime date;
  final int hijriDay;
  final bool isSelected;
  final bool isWeekend;
  final bool isToday;

  const CalendarDateCellViewModel({
    required this.date,
    required this.hijriDay,
    required this.isSelected,
    required this.isWeekend,
    this.isToday = false,
  });

  bool get isSelectedAndWeekend => isSelected && isWeekend;
}
