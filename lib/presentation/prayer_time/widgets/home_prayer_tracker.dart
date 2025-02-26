import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';
import 'package:qibla_and_prayer_times/presentation/common/widgets/prayer_tracker_items.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';

class HomePrayerTracker extends StatelessWidget {
  const HomePrayerTracker({
    super.key,
    required this.theme,
    required this.trackers,
    required this.onTap,
  });

  final ThemeData theme;
  final List<PrayerTrackerModel> trackers;
  final Function(WaqtType) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _buildTrackerHeader(context),
          gapH16,
          PrayerTrackerItems(
            theme: theme,
            trackers: trackers,
            onTap: onTap,
          ),
        ],
      ),
    );
  }

  Row _buildTrackerHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Prayer Tracker',
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: fifteenPx,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'See All',
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: twelvePx,
            fontWeight: FontWeight.normal,
            color: context.color.subTitleColor,
          ),
        ),
      ],
    );
  }
}
