import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar_title.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/prayer_tracker_calendar.dart';

class EventPage extends StatelessWidget {
  EventPage({super.key});
  final PrayerTrackerPresenter presenter = locate<PrayerTrackerPresenter>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: presenter,
      builder: () {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const CustomAppBarTitle(
              title: 'Event & Calender',
            ),
          ),
          body: Column(
            children: [
              PrayerTrackerCalendar(
                theme: theme,
                onDateSelected: presenter.onDateSelected,
                selectedDate: presenter.currentUiState.selectedDate,
                presenter: presenter,
              ),
            ],
          ),
        );
      },
    );
  }
}
