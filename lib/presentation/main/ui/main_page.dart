import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/main/widgets/double_tap_back_to_exit_app.dart';
import 'package:qibla_and_prayer_times/presentation/main/widgets/main_navigation_bar.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/ui/home_page.dart';

import 'package:qibla_and_prayer_times/presentation/prayer_tracker/ui/prayer_tracker_page.dart';
import 'package:qibla_and_prayer_times/presentation/profile/ui/profile_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final MainPresenter _mainPresenter = locate<MainPresenter>();

  final List<Widget> _pages = <Widget>[
    // PrayerTimePage(),
    HomePage(),
    PrayerTrackerPage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DoubleTapBackToExitApp(
      mainPresenter: _mainPresenter,
      child: PresentableWidgetBuilder(
        presenter: _mainPresenter,
        builder: () {
          final MainUiState state = _mainPresenter.currentUiState;
          return Scaffold(
            body: state.selectedBottomNavIndex < _pages.length
                ? _pages[state.selectedBottomNavIndex]
                : _pages[0], // Default to first page if index out of range
            bottomNavigationBar: MainNavigationBar(
              selectedIndex: state.selectedBottomNavIndex,
              onDestinationSelected: (index) {
                if (index >= 2 && index < 4) {
                  showMessage(
                    message: 'Coming soon',
                  );
                  return;
                }
                _mainPresenter.changeNavigationIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
