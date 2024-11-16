// lib/domain/service/time_service.dart

import 'dart:async';
import 'package:rxdart/rxdart.dart';

class TimeService {
  final BehaviorSubject<DateTime> _currentTime = BehaviorSubject<DateTime>();

  Stream<DateTime> get currentTimeStream => _currentTime.stream;
  DateTime get currentTime => DateTime.now();

  TimeService() {
    _initializeTime();
  }

  void _initializeTime() {
    _currentTime.add(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTime.add(DateTime.now());
    });
  }

  void dispose() {
    _currentTime.close();
  }

  DateTime getCurrentDate() {
    final DateTime now = currentTime;
    return DateTime(now.year, now.month, now.day);
  }

  DateTime getCurrentTime() {
    return currentTime;
  }

  DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  bool isToday(DateTime date) {
    final DateTime now = currentTime;
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
