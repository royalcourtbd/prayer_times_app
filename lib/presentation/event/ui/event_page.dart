import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/event/widgets/holiday_section.dart';
import 'package:qibla_and_prayer_times/presentation/event/widgets/ramadan_calendar_banner.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/prayer_tracker_calendar.dart';

class EventPage extends StatelessWidget {
  EventPage({super.key});
  final PrayerTrackerPresenter presenter = locate<PrayerTrackerPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: presenter,
      builder: () {
        return Scaffold(
          appBar: CustomAppBar(
            isRoot: true,
            title: 'Event & Calender',
            theme: theme,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                PrayerTrackerCalendar(
                  theme: theme,
                  onDateSelected: presenter.onDateSelected,
                  selectedDate: presenter.currentUiState.selectedDate,
                  presenter: presenter,
                ),
                gapH30,
                HolidaySection(theme: theme),
                gapH20,
                RamadanCalendarBanner(
                  theme: theme,
                  onCalendarTap: () {
                    // Handle calendar tap
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
