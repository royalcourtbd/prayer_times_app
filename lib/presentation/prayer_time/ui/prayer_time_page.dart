import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/countdown_progress_bar.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/daily_waqt_view.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/notification_permission_section.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/prayer_time_page_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/prayer_tracker_widget.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/sehri_and_iftar_schedule_card.dart';

class PrayerTimePage extends StatelessWidget {
  PrayerTimePage({super.key});
  final PrayerTimePresenter _prayerTimePresenter =
      locate<PrayerTimePresenter>();
  late final MainPresenter _mainPresenter = locate<MainPresenter>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PresentableWidgetBuilder(
      presenter: _prayerTimePresenter,
      builder: () {
        final PrayerTimeUiState currentUiState =
            _prayerTimePresenter.currentUiState;
        _prayerTimePresenter.updateContext(context);

        return Scaffold(
          appBar: HomePageAppBar(
            theme: theme,
            onTapNotification: () =>
                showMessage(context: context, message: 'Notification'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: padding15,
              child: Column(
                children: [
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUiState.hijriDate ?? '',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: context.color.titleColor,
                            fontSize: fourteenPx,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        gapH5,
                        Text(
                          _prayerTimePresenter.getCurrentTime(),
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: context.color.titleColor,
                            fontSize: thirtyNinePx,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        gapH16,
                        CountdownProgressBar(
                          theme: theme,
                          progress: currentUiState.remainingTimeProgress,
                          remainingTime:
                              _prayerTimePresenter.getFormattedRemainingTime(),
                          title: _prayerTimePresenter.getRemainingTimeText(),
                        ),
                        gapH25,
                        DailyWaqtView(
                          theme: theme,
                          waqtList: _prayerTimePresenter.waqtList,
                        ),
                        gapH25,
                        NotificationPermissionSection(
                          theme: theme,
                          notifyMe: currentUiState.notifyMe,
                          onChanged: (value) =>
                              _prayerTimePresenter.toggleNotifyMe(value),
                        ),
                      ],
                    ),
                  ),
                  gapH16,
                  SehriIftarScheduleCard(
                    theme: theme,
                    sehriTime: _prayerTimePresenter.getSehriTime(),
                    iftarTime: _prayerTimePresenter.getIftarTime(),
                    remainingTime:
                        _prayerTimePresenter.getFormattedFastingRemainingTime(),
                    progress: currentUiState.fastingProgress,
                    title: currentUiState.fastingState.displayName,
                  ),
                  gapH16,
                  PrayerTrackerWidget(
                    theme: theme,
                    trackers: currentUiState.prayerTrackers,
                    onTap: (p0) => _prayerTimePresenter.togglePrayerStatus(p0),
                    showCalendarIcon: true,
                    onCalendarTap: () =>
                        _mainPresenter.changeNavigationIndex(1),
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
