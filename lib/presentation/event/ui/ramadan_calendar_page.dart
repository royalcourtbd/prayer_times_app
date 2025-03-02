import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/ramadan_day_entity.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/common/rounded_top_container.dart';
import 'package:qibla_and_prayer_times/presentation/event/pesenter/ramadan_calendar_presenter.dart';

class RamadanCalendarPage extends StatelessWidget {
  final RamadanCalendarPresenter _presenter =
      locate<RamadanCalendarPresenter>();

  RamadanCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PresentableWidgetBuilder<RamadanCalendarPresenter>(
      presenter: _presenter,
      builder: () {
        final calendarState = _presenter.currentUiState;

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(SvgPath.appBgJpg),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              theme: theme,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ramadan Calendar 2025',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: twentyTwoPx,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapH10,
                    Text(
                      calendarState.location != null
                          ? 'Ramadan Time Schedule in ${calendarState.location?.placeName}\n(GMT +6) Hijri 1446'
                          : 'Ramadan Time Schedule in Dhaka\nDistrict (GMT +6) Hijri 1446',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: thirteenPx,
                      ),
                    ),
                    gapH30,
                    RoundedTopContainer(
                      children: [
                        Text(
                          'Ramadan 2025 Timetable',
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: sixteenPx,
                          ),
                        ),
                        gapH20,
                        calendarState.isLoading
                            ? _buildLoadingIndicator()
                            : _buildCalendarTable(
                                calendarState.ramadanCalendar,
                                theme,
                                calendarState.currentRamadanDay - 1,
                              ),
                        gapH20,
                        Text(
                          'Follow the Sehri and Iftar timing according to your local mosque or authorities during Ramadan.',
                          style: theme.textTheme.bodySmall!.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildCalendarTable(
      List<RamadanDayEntity> calendarData, ThemeData theme, int currentDay) {
    return Column(
      children: [
        _buildTableHeader(theme),
        _buildTableBody(calendarData, theme, currentDay),
      ],
    );
  }

  Widget _buildTableHeader(ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: twelvePx, horizontal: eightPx),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacityInt(0.1),
        borderRadius: radius8,
      ),
      child: Row(
        children: [
          _headerCell('Ramadan', 0.28, theme),
          _headerCell('Date', 0.25, theme),
          _headerCell('Day', 0.25, theme),
          _headerCell('Sehri', 0.2, theme),
          _headerCell('Iftar', 0.2, theme),
        ],
      ),
    );
  }

  Widget _headerCell(String text, double flex, ThemeData theme) {
    return Expanded(
      flex: (flex * 100).toInt(),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: twelvePx,
        ),
      ),
    );
  }

  Widget _buildTableBody(
      List<RamadanDayEntity> data, ThemeData theme, int currentDay) {
    // if data is empty
    if (data.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Loading failed, please try again',
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      );
    }

    // show all 30 days of Ramadan
    return Column(
      children: List.generate(
        data.length,
        (index) => _buildTableRow(
          data[index],
          index,
          theme,
          isHighlighted: currentDay >= 0 && currentDay < 30
              ? index == currentDay
              : false, // highlight current day
          isLastRow: index == data.length - 1,
        ),
      ),
    );
  }

  Widget _buildTableRow(
    RamadanDayEntity data,
    int index,
    ThemeData theme, {
    bool isHighlighted = false,
    bool isLastRow = false,
  }) {
    final Color rowColor = isHighlighted
        ? theme.primaryColor
        : index % 2 == 0
            ? Colors.transparent
            : theme.primaryColor.withOpacityInt(0.1);

    return Container(
      padding: EdgeInsets.symmetric(vertical: eightPx),
      decoration: BoxDecoration(
        color: rowColor,
        borderRadius: radius8,
      ),
      child: Row(
        children: [
          _tableCell(data.day, 0.28, theme, isHighlighted: isHighlighted),
          _tableCell(data.date, 0.25, theme, isHighlighted: isHighlighted),
          _tableCell(data.weekday, 0.25, theme, isHighlighted: isHighlighted),
          _tableCell(data.sehriTime, 0.2, theme, isHighlighted: isHighlighted),
          _tableCell(data.iftarTime, 0.2, theme, isHighlighted: isHighlighted),
        ],
      ),
    );
  }

  Widget _tableCell(String text, double flex, ThemeData theme,
      {bool isHighlighted = false}) {
    return Expanded(
      flex: (flex * 100).toInt(),
      child: Padding(
        padding: paddingV8,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: elevenPx,
            color: isHighlighted ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
