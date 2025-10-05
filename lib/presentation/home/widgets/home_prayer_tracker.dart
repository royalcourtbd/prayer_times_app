import 'package:flutter/material.dart';
import 'package:salat_times/core/di/service_locator.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/data/models/prayer_tracker_model.dart';
import 'package:salat_times/presentation/common/prayer_tracker_items.dart';
import 'package:salat_times/presentation/common/section_header_with_action.dart';
import 'package:salat_times/presentation/home/models/waqt.dart';
import 'package:salat_times/presentation/main/presenter/main_presenter.dart';

class HomePrayerTracker extends StatelessWidget {
  HomePrayerTracker({
    super.key,
    required this.theme,
    required this.trackers,
    required this.onTap,
  });

  final ThemeData theme;
  final List<PrayerTrackerModel> trackers;
  final Function(WaqtType) onTap;
  late final MainPresenter _mainPresenter = locate<MainPresenter>();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('prayer_tracker_container'),
      padding: padding15,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.color.primaryColor.withOpacityInt(0.05),
        borderRadius: radius18,
        border: Border.all(
          color: context.color.primaryColor.withOpacityInt(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          SectionHeaderWithAction(
            key: Key('prayer_tracker_header'),
            title: 'Prayer Tracker',
            actionText: 'See All',
            onActionTap: () => _mainPresenter.changeNavigationIndex(1),
          ),
          gapH16,
          PrayerTrackerItems(
            key: Key('prayer_tracker_items'),
            theme: theme,
            trackers: trackers,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
