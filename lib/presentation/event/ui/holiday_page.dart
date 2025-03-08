import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';

import 'package:qibla_and_prayer_times/presentation/event/pesenter/event_presenter.dart';

class HolidayPage extends StatelessWidget {
  const HolidayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final EventPresenter presenter = locate<EventPresenter>();

    return Scaffold(
      appBar: CustomAppBar(theme: theme, title: 'Govt Holiday\'s 2025'),
      body: Column(
        children: [],
      ),
    );
  }
}
