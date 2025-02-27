import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/event/pesenter/event_ui_state.dart';

class EventPresenter extends BasePresenter<EventUiState> {
  final Obs<EventUiState> uiState = Obs(EventUiState.empty());
  EventUiState get currentUiState => uiState.value;

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
  final String date;
  final Color color;

  EventModel({
    required this.title,
    required this.description,
    required this.date,
    required this.color,
  });
}

List<EventModel> eventList = [
  EventModel(
    title: 'New Year\'s Day',
    description:
        'Day commemorating language martyrs and promoting linguistic diversity',
    date: '2025-02-28',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Australia Day',
    description: 'National day of Australia',
    date: '2025-01-27',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Shab-e-Barat',
    description: 'Islamic holy night of forgiveness',
    date: '2025-02-15',
    color: Colors.green,
  ),
  EventModel(
    title: 'Shaheed Day & International Mother Language Day',
    description:
        'Day commemorating language martyrs and promoting linguistic diversity',
    date: '2025-02-21',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Canberra Day',
    description: 'Holiday celebrating the naming of Canberra',
    date: '2025-03-10',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Independence & National Day',
    description: 'Celebration of national independence',
    date: '2025-03-26',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Jumatun Widah',
    description: 'The last Friday of Ramadan',
    date: '2025-03-28',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid-ul-Fitr',
    description: 'Islamic festival marking the end of Ramadan',
    date: '2025-03-31',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid-ul-Fitr (Day 2)',
    description: 'Second day of Eid-ul-Fitr celebrations',
    date: '2025-04-01',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid-ul-Fitr (Day 3)',
    description: 'Third day of Eid-ul-Fitr celebrations',
    date: '2025-04-02',
    color: Colors.green,
  ),
  EventModel(
    title: 'Bangla New Year\'s Day',
    description: 'Bengali New Year celebration',
    date: '2025-04-14',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Baisabi',
    description:
        'Traditional new year festival celebrated by various ethnic groups',
    date: '2025-04-15',
    color: Colors.blue,
  ),
  EventModel(
    title: 'ANZAC Day',
    description: 'Day of remembrance honoring military veterans',
    date: '2025-04-25',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Buddha Purnima',
    description: 'Buddhist festival celebrating Buddha\'s birthday',
    date: '2025-05-11',
    color: Colors.orange,
  ),
  EventModel(
    title: 'Reconciliation Day',
    description:
        'Day promoting reconciliation between indigenous and non-indigenous people',
    date: '2025-06-02',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Sovereign\'s Birthday',
    description: 'Celebration of the monarch\'s birthday',
    date: '2025-06-09',
    color: Colors.blue,
  ),
  EventModel(
    title: 'Eid-ul-Azha',
    description: 'Islamic festival of sacrifice',
    date: '2025-06-06',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid-ul-Azha (Day 2)',
    description: 'Second day of Eid-ul-Azha celebrations',
    date: '2025-06-09',
    color: Colors.green,
  ),
  EventModel(
    title: 'Eid-ul-Azha (Day 3)',
    description: 'Third day of Eid-ul-Azha celebrations',
    date: '2025-06-10',
    color: Colors.green,
  ),
];
