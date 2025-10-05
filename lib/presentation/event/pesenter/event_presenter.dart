import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salat_times/core/base/base_presenter.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/presentation/event/pesenter/event_ui_state.dart';

class EventPresenter extends BasePresenter<EventUiState> {
  final Obs<EventUiState> uiState = Obs(EventUiState.empty());
  EventUiState get currentUiState => uiState.value;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    processEvents();

    // TextEditingController এ লিসেনার যোগ করি যাতে ইনপুট পরিবর্তন হলেও সার্চ কাজ করে
    searchController.addListener(() {
      if (currentUiState.searchQuery != searchController.text) {
        updateSearchQuery(searchController.text);
      }
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // সার্চ কুয়েরি আপডেট মেথড
  void updateSearchQuery(String query) {
    if (currentUiState.searchQuery != query) {
      uiState.value = currentUiState.copyWith(searchQuery: query);
      processEvents();
    }
  }

  // ইভেন্ট প্রসেসিং এবং গ্রুপিং মেথড
  void processEvents() {
    final filteredAndSortedEvents =
        _processEvents(eventList, currentUiState.searchQuery);
    final groupedEvents = _groupEventsByMonth(filteredAndSortedEvents);
    uiState.value = currentUiState.copyWith(groupedEvents: groupedEvents);
  }

  // ইভেন্ট ফিল্টারিং মেথড
  List<EventModel> _processEvents(List<EventModel> events, String query) {
    var filteredEvents = events;
    if (query.isNotEmpty) {
      filteredEvents = events
          .where((event) =>
              event.title.toLowerCase().contains(query.toLowerCase()) ||
              event.description.toLowerCase().contains(query.toLowerCase()) ||
              event.holidayType.toLowerCase().contains(query.toLowerCase()))
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

  // কন্ট্রোলার ক্লিয়ার করার মেথড
  void clearSearchController() {
    searchController.clear();
    updateSearchQuery('');
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
    title: 'Shab e-Barat',
    description: 'Islamic holy night of forgiveness',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-02-15',
    color: Colors.green,
  ),
  EventModel(
    title: 'Shaheed Day',
    description: 'Day commemorating language martyrs',
    holidayType: 'Cultural Festival in Bangladesh',
    date: '2025-02-21',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Independence Day',
    description: 'Celebration of national independence',
    holidayType: 'National Holiday in Bangladesh',
    date: '2025-03-26',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Laylat al-Qadr',
    description: 'Islamic night of power and destiny',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-03-27',
    color: Colors.green,
  ),
  EventModel(
    title: 'Jumatul Bidah',
    description: 'The last Friday of Ramadan',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-03-28',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid ul-Fitr Holiday',
    description: 'Holiday before Eid ul-Fitr',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-03-29',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid ul-Fitr Holiday',
    description: 'Holiday before Eid ul-Fitr',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-03-30',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid ul-Fitr',
    description: 'Islamic festival marking the end of Ramadan',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-03-31',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid ul-Fitr Holiday',
    description: 'Second day of Eid ul-Fitr celebrations',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-04-01',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid ul-Fitr Holiday',
    description: 'Third day of Eid ul-Fitr celebrations',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-04-02',
    color: Colors.green,
  ),
  EventModel(
    title: 'Bengali New Year',
    description: 'Bengali New Year celebration',
    holidayType: 'Cultural Festival in Bangladesh',
    date: '2025-04-14',
    color: Colors.blue,
  ),
  EventModel(
    title: 'May Day',
    description: 'International Workers\' Day',
    holidayType: 'National Holiday in Bangladesh',
    date: '2025-05-01',
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
    title: 'Eid ul-Adha Holiday',
    description: 'Holiday before Eid ul-Adha',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-06-05',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid ul-Adha Holiday',
    description: 'Holiday before Eid ul-Adha',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-06-06',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid ul-Adha',
    description: 'Islamic festival of sacrifice',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-06-07',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid ul-Adha Holiday',
    description: 'Second day of Eid ul-Adha celebrations',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-06-08',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid ul-Adha Holiday',
    description: 'Third day of Eid ul-Adha celebrations',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-06-09',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid ul-Adha Holiday',
    description: 'Fourth day of Eid ul-Adha celebrations',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-06-10',
    color: Colors.green,
  ),
  EventModel(
    title: 'Ashura',
    description: 'Islamic day of remembrance',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-07-06',
    color: Colors.green,
  ),
  EventModel(
    title: 'National Mourning Day',
    description: 'Day commemorating national tragedy',
    holidayType: 'National Holiday in Bangladesh',
    date: '2025-08-15',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Shuba Janmashtami',
    description: 'Hindu festival celebrating Krishna\'s birth',
    holidayType: 'Cultural Festival in Bangladesh',
    date: '2025-08-16',
    color: Colors.orange,
  ),
  EventModel(
    title: 'Eid-e-Milad un-Nabi',
    description: 'Celebration of Prophet Muhammad\'s birthday',
    holidayType: 'Islamic Festival in Bangladesh',
    date: '2025-09-05',
    color: Colors.green,
  ),
  EventModel(
    title: 'Vijaya Dashami',
    description: 'Hindu festival celebrating victory of good over evil',
    holidayType: 'Cultural Festival in Bangladesh',
    date: '2025-10-02',
    color: Colors.orange,
  ),
  EventModel(
    title: 'Victory Day',
    description: 'Celebration of victory in the Liberation War',
    holidayType: 'National Holiday in Bangladesh',
    date: '2025-12-16',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Christmas Day',
    description: 'Christian festival celebrating the birth of Jesus',
    holidayType: 'Holiday in Bangladesh',
    date: '2025-12-25',
    color: Colors.red,
  ),
];
