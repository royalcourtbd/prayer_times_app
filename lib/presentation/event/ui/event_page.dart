import 'package:flutter/material.dart';
import 'package:prayer_times/core/di/service_locator.dart';
import 'package:prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/presentation/common/custom_app_bar.dart';
import 'package:prayer_times/presentation/event/pesenter/event_presenter.dart';
import 'package:prayer_times/presentation/event/ui/ramadan_calendar_page.dart';
import 'package:prayer_times/presentation/event/widgets/holiday_section.dart';
import 'package:prayer_times/presentation/event/widgets/ramadan_calendar_banner.dart';
import 'package:prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:prayer_times/presentation/event/widgets/event_calendar.dart';

class EventPage extends StatelessWidget {
  EventPage({super.key});
  final PrayerTrackerPresenter _prayerTrackerPresenter =
      locate<PrayerTrackerPresenter>();
  final EventPresenter _eventPresenter = locate<EventPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _prayerTrackerPresenter,
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
                EventCalendar(
                  theme: theme,
                  onDateSelected: _prayerTrackerPresenter.onDateSelected,
                  selectedDate:
                      _prayerTrackerPresenter.currentUiState.selectedDate,
                  presenter: _prayerTrackerPresenter,
                ),
                gapH30,
                HolidaySection(theme: theme, eventPresenter: _eventPresenter),
                gapH20,
                RamadanCalendarBanner(
                  theme: theme,
                  onCalendarTap: () =>
                      context.navigatorPush(RamadanCalendarPage()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
