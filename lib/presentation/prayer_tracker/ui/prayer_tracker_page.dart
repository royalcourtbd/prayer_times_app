import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/calendar_header_widget.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar_title.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/widgets/prayer_tracker_widget.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';

class PrayerTrackerPage extends StatelessWidget {
  PrayerTrackerPage({super.key});

  final PrayerTrackerPresenter _presenter = locate<PrayerTrackerPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _presenter,
      builder: () {
        // final PrayerTrackerUiState currentUiState = _presenter.currentUiState;

        return Scaffold(
          appBar: AppBar(
            title: const CustomAppBarTitle(
              title: 'Prayer Tracker',
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: paddingH20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH10,
                  CalendarHeaderWidget(
                    theme: theme,
                    selectedDate: _presenter.currentUiState.selectedDate,
                    onPreviousDate: _presenter.onPreviousDate,
                    onNextDate: _presenter.onNextDate,
                    isEventCalendar: false,
                    onTap: () {
                      print('tapped');
                    },
                  ),
                  gapH16,
                  PrayerTrackerWidget(
                    theme: theme,
                    trackers: _presenter.currentUiState.prayerTrackers,
                    onTap: (type) => _presenter.togglePrayerStatus(type: type),
                  ),
                  gapH25,
                  Text(
                    'All Tracking History',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: sixteenPx,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  gapH10,
                  // GovtHolidayList(
                  //   theme: theme,
                  //   events: _presenter.currentUiState.prayerTrackers,
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
