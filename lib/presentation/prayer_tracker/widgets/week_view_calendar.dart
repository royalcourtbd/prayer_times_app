import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';

import 'package:qibla_and_prayer_times/presentation/prayer_tracker/model/calendar_date_cell_view_model.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/calendar_date_cell.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/day_name_list.dart';

class WeekViewCalendar extends StatelessWidget {
  const WeekViewCalendar({
    required this.theme,
    required this.selectedDate,
    required this.onDateSelected,
    required this.presenter,
    super.key,
  });

  final ThemeData theme;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final PrayerTrackerPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DayNameList(theme: theme),
        gapH16,
        _ScrollableCalendarView(
          theme: theme,
          selectedDate: selectedDate,
          onDateSelected: onDateSelected,
          presenter: presenter,
        ),
      ],
    );
  }
}

class _ScrollableCalendarView extends StatefulWidget {
  const _ScrollableCalendarView({
    required this.theme,
    required this.selectedDate,
    required this.onDateSelected,
    required this.presenter,
  });

  final ThemeData theme;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final PrayerTrackerPresenter presenter;

  @override
  State<_ScrollableCalendarView> createState() =>
      _ScrollableCalendarViewState();
}

class _ScrollableCalendarViewState extends State<_ScrollableCalendarView> {
  // তারিখের রেঞ্জ - আরও তারিখ দেখাতে এটা বাড়ানো যেতে পারে
  static const int daysBeforeSelected = 15;
  static const int daysAfterSelected = 30;

  // স্ক্রোল কন্ট্রোলার
  late final PageController _pageController;
  late final int totalPages;
  late final int initialPage;

  @override
  void initState() {
    super.initState();

    // প্রতি পেজে 7 দিন থাকবে (একটি পূর্ণ সপ্তাহ)
    totalPages = ((daysBeforeSelected + daysAfterSelected + 1) / 7).ceil();

    // সিলেক্টেড ডেট যে পেজে আছে সেই পেজটি নির্ধারণ করা
    final DateTime firstDate = _getFirstDate();
    final int daysBetween = widget.selectedDate.difference(firstDate).inDays;
    initialPage = daysBetween ~/ 7;

    _pageController = PageController(initialPage: initialPage);
  }

  DateTime _getFirstDate() {
    return widget.selectedDate.subtract(
      const Duration(days: daysBeforeSelected),
    );
  }

  @override
  void didUpdateWidget(_ScrollableCalendarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate) {
      _scrollToSelectedDate();
    }
  }

  void _scrollToSelectedDate() {
    // সিলেক্টেড ডেট থেকে প্রথম ডেট এর দূরত্ব নির্ণয়
    final DateTime firstDate = _getFirstDate();
    final int daysBetween = widget.selectedDate.difference(firstDate).inDays;
    final int pageIndex = daysBetween ~/ 7;

    // স্ক্রোল করা (animate করে)
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ড্র্যাগ অফসেট পরিবর্তনের জন্য লিসেন করা
    return Obx(() {
      // প্রথম দিন ক্যালকুলেট
      final DateTime firstDate = _getFirstDate();
      final double dragOffset = widget.presenter.currentUiState.dragOffset;

      return GestureDetector(
        onHorizontalDragUpdate: (DragUpdateDetails details) =>
            widget.presenter.handleHorizontalDrag(details),
        onHorizontalDragEnd: (DragEndDetails details) =>
            widget.presenter.handleSwipe(details),
        child: SizedBox(
          height: 15.percentWidth, // ক্যালেন্ডার সেলের উচ্চতা
          child: Transform.translate(
            offset: Offset(dragOffset, 0),
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              itemBuilder: (context, pageIndex) {
                // প্রতি পেজের শুরুর তারিখ ক্যালকুলেট
                final DateTime pageStartDate =
                    firstDate.add(Duration(days: pageIndex * 7));
                // সেই তারিখ থেকে সপ্তাহের প্রথম দিন (রবিবার) নির্ণয়
                final int daysToSubtract = pageStartDate.weekday % 7;
                final DateTime weekStartDate =
                    pageStartDate.subtract(Duration(days: daysToSubtract));
                return _buildWeekRow(context, weekStartDate);
              },
            ),
          ),
        ),
      );
    });
  }

  Widget _buildWeekRow(BuildContext context, DateTime startOfWeek) {
    // startOfWeek এখন অবশ্যই সপ্তাহের প্রথম দিন (রবিবার)
    return Row(
      children: List.generate(7, (dayIndex) {
        final DateTime date = startOfWeek.add(Duration(days: dayIndex));
        return Expanded(
          child: _buildDateCell(context, date),
        );
      }),
    );
  }

  Widget _buildDateCell(BuildContext context, DateTime date) {
    final HijriCalendar hijri = HijriCalendar.fromDate(date);
    final DateTime now = DateTime.now();
    final bool isToday =
        date.day == now.day && date.month == now.month && date.year == now.year;
    final bool isSelected = date.day == widget.selectedDate.day &&
        date.month == widget.selectedDate.month &&
        date.year == widget.selectedDate.year;
    final bool isWeekend = date.weekday == 5 || date.weekday == 6;

    return CalendarDateCell(
      viewModel: CalendarDateCellViewModel(
        date: date,
        hijriDay: hijri.hDay,
        isSelected: isSelected,
        isWeekend: isWeekend,
        isToday: isToday,
      ),
      theme: widget.theme,
      onTap: widget.onDateSelected,
      presenter: widget.presenter,
    );
  }
}
