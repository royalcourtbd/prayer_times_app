import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_tracker_entity.dart';
import 'package:qibla_and_prayer_times/domain/service/time_service.dart';
import 'package:qibla_and_prayer_times/domain/service/waqt_calculation_service.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_tracker_data_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/save_prayer_tracker_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_ui_state.dart';

class PrayerTrackerPresenter extends BasePresenter<PrayerTrackerUiState> {
  final WaqtCalculationService _waqtCalculationService;
  final TimeService _timeService;
  final SavePrayerTrackerUseCase _savePrayerTrackerUseCase;
  final GetPrayerTrackerDataUseCase _getPrayerTrackerDataUseCase;

  PrayerTrackerPresenter(
    this._waqtCalculationService,
    this._timeService,
    this._savePrayerTrackerUseCase,
    this._getPrayerTrackerDataUseCase,
  );

  final Obs<PrayerTrackerUiState> uiState = Obs(PrayerTrackerUiState.empty());
  PrayerTrackerUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    super.onInit();
    _loadPrayerTrackerData();
  }

  void togglePrayerStatus({required WaqtType type}) {
    if (!currentUiState.prayerTrackers[type.index].isSelectable) {
      addUserMessage('Prayer time is not yet reached');
      return;
    }

    final List<PrayerTrackerModel> trackers =
        List<PrayerTrackerModel>.from(currentUiState.prayerTrackers);
    final PrayerStatus currentStatus = trackers[type.index].status;

    final PrayerStatus newStatus = currentStatus == PrayerStatus.none
        ? PrayerStatus.completed
        : PrayerStatus.none;

    trackers[type.index] = trackers[type.index].copyWith(
      status: newStatus,
      updatedAt: _timeService.getCurrentTime(),
    );

    uiState.value = currentUiState.copyWith(prayerTrackers: trackers);
    if (newStatus == PrayerStatus.completed) {
      addUserMessage("✅  ${type.displayName} prayer completed. Alhamdulillah!");
    } else {
      addUserMessage('❌  ${type.displayName} prayer not completed.');
    }

    _savePrayerTrackerData();
  }

  void initializePrayerTracker({required PrayerTimeEntity prayerTimeEntity}) {
    final DateTime now = _timeService.getCurrentTime();
    final List<PrayerTrackerModel> trackers = [];

    for (final WaqtType type in WaqtType.values) {
      final DateTime? waqtTime = _waqtCalculationService.getWaqtTime(
        type,
        prayerTimeEntity,
      );
      final bool isSelectable = waqtTime != null && waqtTime.isBefore(now);

      trackers.add(PrayerTrackerModel(
        id: type.toString(),
        createdAt: now,
        updatedAt: now,
        type: type,
        isSelectable: isSelectable,
      ));
    }

    uiState.value = currentUiState.copyWith(prayerTrackers: trackers);
    _loadPrayerTrackerData();
  }

  void onDateSelected(DateTime date) {
    uiState.value = currentUiState.copyWith(selectedDate: date);
    _loadPrayerTrackerData();
  }

  void onPreviousWeek() {
    final DateTime newDate =
        currentUiState.selectedDate.subtract(const Duration(days: 7));
    uiState.value = currentUiState.copyWith(selectedDate: newDate);
    _loadPrayerTrackerData();
  }

  void onNextWeek() {
    final DateTime newDate =
        currentUiState.selectedDate.add(const Duration(days: 7));
    uiState.value = currentUiState.copyWith(selectedDate: newDate);
    _loadPrayerTrackerData();
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
      return Colors.white;
    }
    if (isSelected) {
      return context.color.whiteColor;
    }
    if (isWeekend) {
      return context.color.errorColor;
    }

    return context.color.titleColor;
  }

  void _savePrayerTrackerData() async {
    await parseDataFromEitherWithUserMessage(
      task: () => _savePrayerTrackerUseCase.execute(
        date: _timeService.getStartOfDay(currentUiState.selectedDate),
        trackerData: jsonEncode(
            currentUiState.prayerTrackers.map((e) => e.toJson()).toList()),
      ),
      onDataLoaded: (result) {
        addUserMessage('Prayer tracker data saved successfully');
      },
    );
  }

  Future<void> _loadPrayerTrackerData() async {
    await parseDataFromEitherWithUserMessage(
      task: () => _getPrayerTrackerDataUseCase.execute(
        date: _timeService.getStartOfDay(currentUiState.selectedDate),
      ),
      onDataLoaded: (result) {
        if (result == null) {
          uiState.value = currentUiState.copyWith(
              prayerTrackers: _getInitialTrackers(currentUiState.selectedDate));

          return;
        }

        final List<dynamic> decodedData = jsonDecode(result);
        final List<PrayerTrackerModel> trackers =
            decodedData.map((e) => PrayerTrackerModel.fromJson(e)).toList();
        uiState.value = currentUiState.copyWith(prayerTrackers: trackers);
      },
    );
  }

  List<PrayerTrackerModel> _getInitialTrackers(DateTime selectedDate) {
    final DateTime now = _timeService.getCurrentTime();
    final List<PrayerTrackerModel> trackers = [];

    for (final type in WaqtType.values) {
      final bool isSelectable =
          _timeService.getStartOfDay(selectedDate).isBefore(now);
      trackers.add(PrayerTrackerModel(
        id: type.toString(),
        createdAt: now,
        updatedAt: now,
        type: type,
        isSelectable: isSelectable,
      ));
    }
    return trackers;
  }

  void onPreviousDate() {
    final DateTime newDate =
        currentUiState.selectedDate.subtract(const Duration(days: 1));
    uiState.value = currentUiState.copyWith(selectedDate: newDate);
    _loadPrayerTrackerData();
  }

  void onNextDate() {
    final DateTime newDate =
        currentUiState.selectedDate.add(const Duration(days: 1));
    uiState.value = currentUiState.copyWith(selectedDate: newDate);
    _loadPrayerTrackerData();
  }

  bool canSelectNextDate() {
    final DateTime now = DateTime.now();
    final DateTime nextDate =
        currentUiState.selectedDate.add(const Duration(days: 1));
    return !nextDate.isAfter(now);
  }

  void updateContext({required BuildContext context}) {
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
}
