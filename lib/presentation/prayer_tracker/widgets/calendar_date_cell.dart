// lib/presentation/prayer_tracker/widgets/calendar_date_cell.dart

import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/model/calendar_date_cell_view_model.dart';
import '../presenter/prayer_tracker_presenter.dart';

class CalendarDateCell extends StatelessWidget {
  const CalendarDateCell({
    required this.viewModel,
    required this.theme,
    required this.onTap,
    required this.presenter,
    super.key,
  });

  final CalendarDateCellViewModel viewModel;
  final ThemeData theme;
  final Function(DateTime) onTap;
  final PrayerTrackerPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(viewModel.date),
      child: Container(
        padding: padding3,
        decoration: BoxDecoration(
          color: viewModel.isSelected
              ? context.color.primaryColor100
              : Colors.transparent,
          border: viewModel.isToday
              ? Border.all(color: context.color.primaryColor, width: 1)
              : null,
          borderRadius: radius15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _HijriDateContainer(
              hijriDay: viewModel.hijriDay,
              isSelected: viewModel.isSelected,
              theme: theme,
              presenter: presenter,
              viewModel: viewModel,
            ),
            gapH4,
            _GregorianDateText(
              date: viewModel.date,
              theme: theme,
              presenter: presenter,
              viewModel: viewModel,
            ),
          ],
        ),
      ),
    );
  }
}

class _HijriDateContainer extends StatelessWidget {
  const _HijriDateContainer({
    required this.hijriDay,
    required this.isSelected,
    required this.theme,
    required this.presenter,
    required this.viewModel,
  });

  final int hijriDay;
  final bool isSelected;
  final ThemeData theme;
  final PrayerTrackerPresenter presenter;
  final CalendarDateCellViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 7.percentWidth,
      decoration: BoxDecoration(
        color: isSelected ? context.color.primaryColor : Colors.transparent,
        borderRadius: radius15,
      ),
      child: Text(
        hijriDay.toString(),
        style: theme.textTheme.bodyMedium!.copyWith(
          color: presenter.getHijriTextColor(
            isSelected: viewModel.isSelected,
            isWeekend: viewModel.isWeekend,
            context: context,
          ),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          fontSize: fourteenPx,
        ),
      ),
    );
  }
}

class _GregorianDateText extends StatelessWidget {
  const _GregorianDateText({
    required this.date,
    required this.theme,
    required this.presenter,
    required this.viewModel,
  });

  final DateTime date;
  final ThemeData theme;
  final PrayerTrackerPresenter presenter;
  final CalendarDateCellViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      date.day.toString(),
      style: theme.textTheme.bodySmall!.copyWith(
        color: presenter.getDateTextColor(
          isSelected: viewModel.isSelected,
          isWeekend: viewModel.isWeekend,
          context: context,
        ),
        fontSize: twelvePx,
        fontWeight: viewModel.isSelected ? FontWeight.w500 : FontWeight.w400,
      ),
    );
  }
}
