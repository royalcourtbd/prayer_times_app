import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/presenter/home_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/home_page_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/clock_section.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/home_prayer_tracker.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/location_section.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/prayer_time_list.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/ramadan_tracker_section.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/remaining_prayer_section.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomePresenter _homePresenter = locate<HomePresenter>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PresentableWidgetBuilder(
        presenter: _homePresenter,
        onInit: () {
          _homePresenter.loadLocationAndPrayerTimes();
        },
        builder: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _homePresenter.scrollToActiveWaqtWithDelay(context);
          });

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(SvgPath.appBgJpg),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: HomePageAppBar(
                theme: theme,
                presenter: _homePresenter,
                onTapFetchLocation: () =>
                    _homePresenter.refreshLocationAndPrayerTimes(),
                onTapCategory: () {},
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: twentyPx,
                        right: twentyPx,
                        top: tenPx,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClockSection(
                            theme: theme,
                            presenter: _homePresenter,
                          ),
                          gapW12,
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LocationSection(
                                  theme: theme,
                                  presenter: _homePresenter,
                                  onBuildContainer: _buildContainer,
                                ),
                                gapH10,
                                RemainingPrayerSection(
                                  theme: theme,
                                  homePresenter: _homePresenter,
                                  onBuildContainer: _buildContainer,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    gapH20,
                    PrayerTimeList(
                      theme: theme,
                      waqtList: _homePresenter.waqtList,
                      scrollController:
                          _homePresenter.prayerTimesScrollController,
                    ),
                    gapH30,
                    _buildHomaPageBottomContainer(
                      children: [
                        HomePrayerTracker(
                          theme: theme,
                          trackers: _homePresenter.prayerTrackerPresenter
                              .currentUiState.prayerTrackers,
                          onTap: (type) => _homePresenter.prayerTrackerPresenter
                              .togglePrayerStatus(type: type),
                        ),
                        gapH15,
                        RamadanTrackerSection(
                          theme: theme,
                          homePresenter: _homePresenter,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Container _buildHomaPageBottomContainer({
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: padding20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacityInt(0.5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(thirtyPx)),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Container _buildContainer({
    required BuildContext context,
    required ThemeData theme,
    required Widget child,
  }) {
    return Container(
      padding: padding10,
      alignment: Alignment.center,
      height: 98,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.color.whiteColor.withOpacityInt(0.5),
        borderRadius: BorderRadius.circular(fourteenPx),
      ),
      child: child,
    );
  }
}
