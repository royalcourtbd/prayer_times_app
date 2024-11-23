import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_ui_state.dart';

class PrayerTrackerPresenter extends BasePresenter<PrayerTrackerUiState> {
  final Obs<PrayerTrackerUiState> uiState = Obs(PrayerTrackerUiState.empty());
  PrayerTrackerUiState get currentUiState => uiState.value;

  void onDateSelected(DateTime date) {
    uiState.value = currentUiState.copyWith(selectedDate: date);
  }

  void onPreviousWeek() {
    final DateTime newDate =
        currentUiState.selectedDate.subtract(const Duration(days: 7));
    uiState.value = currentUiState.copyWith(selectedDate: newDate);
  }

  void onNextWeek() {
    final DateTime newDate =
        currentUiState.selectedDate.add(const Duration(days: 7));
    uiState.value = currentUiState.copyWith(selectedDate: newDate);
  }

  void handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity! > 0) {
      onPreviousWeek();
    } else if (details.primaryVelocity! < 0) {
      onNextWeek();
    }
  }

  Color getDateTextColor({
    required bool isSelected,
    required bool isWeekend,
    required BuildContext context,
  }) {
    if (isSelected && isWeekend) {
      return context.color.errorColor;
    }
    if (isWeekend) {
      return context.color.errorColor;
    }
    return context.color.primaryColor400;
  }

  Color getHijriTextColor({
    required bool isSelected,
    required bool isWeekend,
    required BuildContext context,
  }) {
    if (isSelected && isWeekend) {
      return context.color.errorColor;
    }
    if (isSelected) {
      return context.color.whiteColor;
    }
    if (isWeekend) {
      return context.color.errorColor;
    }

    return context.color.titleColor;
  }

  void updateContext(BuildContext context) {
    uiState.value = currentUiState.copyWith(context: context);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(
        message: currentUiState.userMessage, context: currentUiState.context);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }

  void onPreviousDate() {
    final DateTime newDate =
        currentUiState.selectedDate.subtract(const Duration(days: 1));
    uiState.value = currentUiState.copyWith(selectedDate: newDate);
  }

  void onNextDate() {
    final DateTime newDate =
        currentUiState.selectedDate.add(const Duration(days: 1));
    uiState.value = currentUiState.copyWith(selectedDate: newDate);
  }

  bool canSelectNextDate() {
    final DateTime now = DateTime.now();
    final DateTime nextDate =
        currentUiState.selectedDate.add(const Duration(days: 1));
    return !nextDate.isAfter(now);
  }
}
