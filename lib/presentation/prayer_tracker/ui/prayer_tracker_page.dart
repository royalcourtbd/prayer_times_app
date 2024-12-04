import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar_title.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/prayer_tracker_widget.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/islamic_event_card.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/prayer_tracker_calendar.dart';

class PrayerTrackerPage extends StatelessWidget {
  PrayerTrackerPage({super.key});

  final PrayerTrackerPresenter _presenter = locate<PrayerTrackerPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _presenter,
      builder: () {
        final PrayerTrackerUiState currentUiState = _presenter.currentUiState;
        _presenter.updateContext(context);

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const CustomAppBarTitle(
              title: 'Prayer Tracker',
            ),
          ),
          body: Padding(
            padding: padding15,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PrayerTrackerCalendar(
                    theme: theme,
                    onDateSelected: _presenter.onDateSelected,
                    selectedDate: _presenter.currentUiState.selectedDate,
                    presenter: _presenter,
                  ),
                  gapH16,
                  IslamicEventCard(
                    theme: theme,
                    date: 'Tue, 26 Nov 2024',
                    eventName: 'Shab-e-Meraj (tentative)',
                    eventType: 'Holidays in Bangladesh',
                  ),
                  gapH16,
                  PrayerTrackerWidget(
                    theme: theme,
                    trackers: locate<PrayerTimePresenter>()
                        .currentUiState
                        .prayerTrackers,
                    onTap: (p0) {},
                    showNavigationArrow: true,
                    onNextTap: () => _presenter.onNextDate(),
                    onPreviousTap: () => _presenter.onPreviousDate(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
