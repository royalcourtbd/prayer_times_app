import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/event/pesenter/event_ui_state.dart';

class EventPresenter extends BasePresenter<EventUiState> {
  final Obs<EventUiState> uiState = Obs(EventUiState.empty());
  EventUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    super.onInit();
    processEvents();
  }

  @override
  Future<void> toggleLoading({bool loading = true}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(message: currentUiState.userMessage);
  }

  void updateSearchQuery(String query) {
    uiState.value = currentUiState.copyWith(searchQuery: query);
    processEvents();
    update();
  }

  void processEvents() {
    final filteredAndSortedEvents =
        _processEvents(eventList, currentUiState.searchQuery);
    final groupedEvents = _groupEventsByMonth(filteredAndSortedEvents);
    uiState.value = currentUiState.copyWith(groupedEvents: groupedEvents);
    update();
  }

  List<EventModel> _processEvents(List<EventModel> events, String query) {
    var filteredEvents = events;
    if (query.isNotEmpty) {
      filteredEvents = events
          .where((event) =>
              event.title.toLowerCase().contains(query.toLowerCase()) ||
              event.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    filteredEvents.sort((a, b) => a.date.compareTo(b.date));
    return filteredEvents;
  }

  Map<String, List<EventModel>> _groupEventsByMonth(List<EventModel> events) {
    final Map<String, List<EventModel>> grouped = {};

    for (var event in events) {
      final date = DateTime.parse(event.date);
      final monthName = DateFormat('MMMM').format(date);

      if (!grouped.containsKey(monthName)) {
        grouped[monthName] = [];
      }
      grouped[monthName]!.add(event);
    }

    return grouped;
  }

  (Color, String) getHolidayTypeInfo(EventModel event) {
    if (event.title.contains('Optional')) {
      return (Colors.blue, 'Optional Holiday in Bangladesh');
    } else if (event.title.contains('Cultural') ||
        event.title.contains('Festival')) {
      return (Colors.red, 'Cultural Festival in Bangladesh');
    } else if (event.title.contains('National')) {
      return (Colors.red, 'National Holiday in Bangladesh');
    } else {
      return (Colors.red, 'Holiday in Bangladesh');
    }
  }
}

class EventModel {
  final String title;
  final String description;
  final String holidayType;
  final String date;
  final Color color;

  EventModel({
    required this.title,
    required this.description,
    required this.holidayType,
    required this.date,
    required this.color,
  });
}

List<EventModel> eventList = [
  EventModel(
    title: 'New Year\'s Day',
    description:
        'Day commemorating language martyrs and promoting linguistic diversity',
    holidayType: 'Optional Holiday in Bangladesh',
    date: '2025-02-28',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Australia Day',
    description: 'National day of Australia',
    holidayType: 'National Holiday in Bangladesh',
    date: '2025-01-27',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Shab-e-Barat',
    description: 'Islamic holy night of forgiveness',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-02-15',
    color: Colors.green,
  ),
  EventModel(
    title: 'Shaheed Day & International Mother Language Day',
    description:
        'Day commemorating language martyrs and promoting linguistic diversity',
    holidayType: 'Cultural Festival in Bangladesh',
    date: '2025-02-21',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Canberra Day',
    description: 'Holiday celebrating the naming of Canberra',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-03-10',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Independence & National Day',
    description: 'Celebration of national independence',
    holidayType: 'National Holiday in Bangladesh',
    date: '2025-03-26',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Jumatun Widah',
    description: 'The last Friday of Ramadan',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-03-28',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid-ul-Fitr',
    holidayType: 'Islamic Festival in Bangladesh',
    description: 'Islamic festival marking the end of Ramadan',
    date: '2025-03-31',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid-ul-Fitr (Day 2)',
    description: 'Second day of Eid-ul-Fitr celebrations',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-04-01',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid-ul-Fitr (Day 3)',
    description: 'Third day of Eid-ul-Fitr celebrations',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-04-02',
    color: Colors.green,
  ),
  EventModel(
    title: 'Bangla New Year\'s Day',
    description: 'Bengali New Year celebration',
    holidayType: 'Cultural Festival in Bangladesh',
    date: '2025-04-14',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Baisabi',
    description:
        'Traditional new year festival celebrated by various ethnic groups',
    holidayType: 'Cultural Festival in Bangladesh',
    date: '2025-04-15',
    color: Colors.blue,
  ),
  EventModel(
    title: 'ANZAC Day',
    description: 'Day of remembrance honoring military veterans',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-04-25',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Buddha Purnima',
    description: 'Buddhist festival celebrating Buddha\'s birthday',
    holidayType: 'Cultural Festival in Bangladesh',
    date: '2025-05-11',
    color: Colors.orange,
  ),
  EventModel(
    title: 'Reconciliation Day',
    description:
        'Day promoting reconciliation between indigenous and non-indigenous people',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-06-02',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Sovereign\'s Birthday',
    description: 'Celebration of the monarch\'s birthday',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-06-09',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Eid-ul-Azha',
    description: 'Islamic festival of sacrifice',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-06-06',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid-ul-Azha (Day 2)',
    description: 'Second day of Eid-ul-Azha celebrations',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-06-09',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid-ul-Azha (Day 3)',
    description: 'Third day of Eid-ul-Azha celebrations',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-06-10',
    color: Colors.green,
  ),
];
