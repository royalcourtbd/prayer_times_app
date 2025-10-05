import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/di/service_locator.dart';
import 'package:salat_times/core/external_libs/presentable_widget_builder.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/data/models/prayer_tracker_model.dart';
import 'package:salat_times/presentation/common/calendar_header_widget.dart';
import 'package:salat_times/presentation/common/custom_app_bar_title.dart';
import 'package:salat_times/presentation/prayer_tracker/widgets/prayer_tracker_widget.dart';
import 'package:salat_times/presentation/prayer_tracker/presenter/prayer_tracker_presenter.dart';
import 'package:salat_times/presentation/prayer_tracker/widgets/prayer_tracker_history_widget.dart';

class PrayerTrackerPage extends StatelessWidget {
  PrayerTrackerPage({super.key});

  final PrayerTrackerPresenter _presenter = locate<PrayerTrackerPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _presenter,
      builder: () {
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
                    onTap: () {},
                  ),
                  gapH16,
                  PrayerTrackerWidget(
                    theme: theme,
                    trackers: _presenter.currentUiState.prayerTrackers,
                    onTap: (type) => _presenter.togglePrayerStatus(type: type),
                  ),
                  gapH25,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Tracking History',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: sixteenPx,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: () => _presenter.handleClearButtonTap(context),
                        child: Text(
                          'Clear',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: twelvePx,
                            fontWeight: FontWeight.normal,
                            color: context.color.subTitleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  gapH10,
                  FutureBuilder<Map<DateTime, List<PrayerTrackerModel>>>(
                    future: _presenter.getPrayerTrackerHistory(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 30.percentWidth,
                            ),
                            Center(
                              child: Text(
                                'No data found',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: context.color.titleColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      return PrayerTrackerHistoryWidget(
                        theme: theme,
                        trackerHistory: snapshot.data!,
                      );
                    },
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
