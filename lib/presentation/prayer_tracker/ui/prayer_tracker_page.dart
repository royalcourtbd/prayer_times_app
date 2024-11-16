import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/prayer_tracker_widget.dart';
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
        // final currentUiState = _presenter.currentUiState;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Prayer Tracker',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: context.color.titleColor,
                fontSize: eighteenPx,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Padding(
            padding: padding15,
            child: Column(
              children: [
                // gapH16,
                PrayerTrackerWidget(
                  theme: theme,
                  trackers: locate<PrayerTimePresenter>()
                      .currentUiState
                      .prayerTrackers,
                  onTap: (p0) {},
                  showNavigationArrow: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
