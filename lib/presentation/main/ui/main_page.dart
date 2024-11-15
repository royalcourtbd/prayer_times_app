import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/main/presenter/main_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/main/widgets/main_navigation_bar.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/ui/prayer_time_page.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_traker/ui/prayer_tracker_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final MainPresenter _mainPresenter = locate<MainPresenter>();

  final List<Widget> _pages = <Widget>[
    PrayerTimePage(),
    const PrayerTrackerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    _mainPresenter.updateContext(context);
    return PresentableWidgetBuilder(
      presenter: _mainPresenter,
      builder: () {
        final MainUiState state = _mainPresenter.currentState;
        return Scaffold(
          body: state.selectedBottomNavIndex < _pages.length
              ? _pages[state.selectedBottomNavIndex]
              : _pages[0], // Default to first page if index out of range
          bottomNavigationBar: MainNavigationBar(
            selectedIndex: state.selectedBottomNavIndex,
            onDestinationSelected: (index) {
              if (index >= 2) {
                showMessage(
                  context: context,
                  message: 'Coming soon',
                );
                return;
              }
              _mainPresenter.changeNavigationIndex(index);
            },
          ),
        );
      },
    );
  }
}
