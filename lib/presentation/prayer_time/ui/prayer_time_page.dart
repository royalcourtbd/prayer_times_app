import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/circle_icon_widget.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/prayer_time_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/countdown_progress_bar.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/daily_waqt_view.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/notification_permission_section.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/prayer_time_page_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/sehri_and_iftar_schedule_card.dart';

class PrayerTimePage extends StatelessWidget {
  PrayerTimePage({super.key});
  final PrayerTimePresenter _prayerTimePresenter =
      locate<PrayerTimePresenter>();

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
                          '28 Rabiu Awal, 1445 H',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: context.color.titleColor,
                            fontSize: fourteenPx,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        gapH5,
                        Text(
                          '15:30',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: context.color.titleColor,
                            fontSize: thirtyNinePx,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        gapH16,
                        CountdownProgressBar(
                          theme: theme,
                          remainingTime: '02:30:32',
                          title: 'Asr',
                          progress: 200,
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
                  SehriIftarScheduleCard(theme: theme),
                  gapH16,
                  CustomCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SvgImage(SvgPath.icCrown),
                            gapW10,
                            Text(
                              'Prayer Tracker',
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: context.color.titleColor,
                                fontSize: fourteenPx,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            CircleIconWidget(
                              height: fortyPx,
                              width: fortyPx,
                              icon: SvgPath.icCalenderOutline2,
                            ),
                          ],
                        ),
                        gapH16,
                        CustomCard(
                          backgroundColor: context.color.primaryColor25,
                          child: Row(
                            children: List.generate(
                              5,
                              (index) {
                                return Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: fourPx, vertical: eightPx),
                                    decoration: BoxDecoration(
                                      borderRadius: radius10,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: 8.percentWidth,
                                              height: 8.percentWidth,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: context
                                                      .color.primaryColor900,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 3.percentWidth,
                                              height: 3.percentWidth,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: context
                                                    .color.primaryColor900,
                                              ),
                                            ),
                                          ],
                                        ),
                                        gapH12,
                                        Text(
                                          'Duhr',
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                            color: context.color.titleColor,
                                            fontSize: fourteenPx,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
