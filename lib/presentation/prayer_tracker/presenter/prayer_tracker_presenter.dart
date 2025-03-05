import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_time_entity.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_tracker_entity.dart';
import 'package:qibla_and_prayer_times/domain/service/time_service.dart';
import 'package:qibla_and_prayer_times/domain/service/waqt_calculation_service.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_prayer_tracker_data_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/save_prayer_tracker_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/get_all_prayer_tracker_data_usecase.dart';
import 'package:qibla_and_prayer_times/domain/usecases/clear_all_prayer_tracker_data_usecase.dart';
import 'package:qibla_and_prayer_times/presentation/home/models/waqt.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_ui_state.dart';

class PrayerTrackerPresenter extends BasePresenter<PrayerTrackerUiState> {
  final WaqtCalculationService _waqtCalculationService;
  final TimeService _timeService;
  final SavePrayerTrackerUseCase _savePrayerTrackerUseCase;
  final GetPrayerTrackerDataUseCase _getPrayerTrackerDataUseCase;
  final GetAllPrayerTrackerDataUseCase _getAllPrayerTrackerDataUseCase;
  final ClearAllPrayerTrackerDataUseCase _clearAllPrayerTrackerDataUseCase;

  PrayerTrackerPresenter(
    this._waqtCalculationService,
    this._timeService,
    this._savePrayerTrackerUseCase,
    this._getPrayerTrackerDataUseCase,
    this._getAllPrayerTrackerDataUseCase,
    this._clearAllPrayerTrackerDataUseCase,
  );

  final Obs<PrayerTrackerUiState> uiState = Obs(PrayerTrackerUiState.empty());
  PrayerTrackerUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    super.onInit();
    _loadPrayerTrackerData();
  }

  void resetState() {
    uiState.value = PrayerTrackerUiState.empty();
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
    // if (newStatus == PrayerStatus.completed) {
    //   addUserMessage("✅  ${type.displayName} prayer completed. Alhamdulillah!");
    // } else {
    //   addUserMessage('❌  ${type.displayName} prayer not completed.');
    // }

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

  void handleHorizontalDrag(DragUpdateDetails details) {
    // Screen width for normalization
    const double screenWidthFactor = 300.0;

    // Update dragOffset based on drag delta
    final double newOffset = currentUiState.dragOffset + details.delta.dx;

    // Limit dragOffset to a reasonable range
    final double limitedOffset =
        newOffset.clamp(-screenWidthFactor, screenWidthFactor);

    uiState.value = currentUiState.copyWith(dragOffset: limitedOffset);
  }

  void resetDragOffset() {
    uiState.value = currentUiState.copyWith(dragOffset: 0.0);
  }

  void handleSwipe(DragEndDetails details) {
    // Get current drag offset for the animation effect
    final double offset = currentUiState.dragOffset;

    // Reset the offset first
    resetDragOffset();

    // Swipe velocity threshold
    const double velocityThreshold = 200.0;
    // Strong swipe means changing multiple days
    const int daysToShift = 3;

    // Quick swipe - move multiple days
    if (details.primaryVelocity != null) {
      if (details.primaryVelocity! > velocityThreshold) {
        // Strong right swipe - move back by multiple days
        final DateTime newDate = currentUiState.selectedDate.subtract(
          const Duration(days: daysToShift),
        );
        uiState.value = currentUiState.copyWith(selectedDate: newDate);
        _loadPrayerTrackerData();
      } else if (details.primaryVelocity! < -velocityThreshold) {
        // Strong left swipe - move forward by multiple days
        final DateTime newDate = currentUiState.selectedDate.add(
          const Duration(days: daysToShift),
        );
        // Check if the date is in the future
        if (!newDate.isAfter(DateTime.now())) {
          uiState.value = currentUiState.copyWith(selectedDate: newDate);
          _loadPrayerTrackerData();
        }
      } else if (offset > 50) {
        // Gentle right swipe - move back by a day
        onPreviousDate();
      } else if (offset < -50) {
        // Gentle left swipe - move forward by a day
        onNextDate();
      }
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
        // addUserMessage('Prayer tracker data saved successfully');
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

  Future<Map<DateTime, List<PrayerTrackerModel>>>
      getPrayerTrackerHistory() async {
    final Map<DateTime, List<PrayerTrackerModel>> history = {};

    try {
      final Either<String, List<PrayerTrackerHistoryEntity>> result =
          await _getAllPrayerTrackerDataUseCase.execute();

      return await result.fold(
        (failure) {
          addUserMessage('Failed to load prayer tracker history');
          return history;
        },
        (trackerEntries) {
          for (final entry in trackerEntries) {
            final date = _timeService.getStartOfDay(entry.date);

            if (entry.trackerData != null && entry.trackerData!.isNotEmpty) {
              try {
                final List<dynamic> decodedData =
                    jsonDecode(entry.trackerData!);
                final List<PrayerTrackerModel> trackers = decodedData
                    .map((e) => PrayerTrackerModel.fromJson(e))
                    .toList();

                if (trackers.isNotEmpty) {
                  history[date] = trackers;
                }
              } catch (e) {
                log('JSON parsing error: $e');
              }
            }
          }

          return history;
        },
      );
    } catch (e) {
      log('getPrayerTrackerHistory error: $e');
      return history;
    }
  }

  Future<void> clearAllPrayerTrackerData() async {
    await parseDataFromEitherWithUserMessage(
      task: () => _clearAllPrayerTrackerDataUseCase.execute(),
      onDataLoaded: (result) {
        addUserMessage('সকল প্রেয়ার ট্র্যাকিং ডাটা মুছে ফেলা হয়েছে');
        resetState();
      },
    );
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(message: currentUiState.userMessage);
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
