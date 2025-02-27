import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
import 'package:qibla_and_prayer_times/presentation/common/prayer_tracker_items.dart';
import 'package:qibla_and_prayer_times/presentation/home/models/waqt.dart';

class PrayerTrackerWidget extends StatelessWidget {
  const PrayerTrackerWidget({
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
    return CustomCard(
      border: Border.all(
        color: Colors.transparent,
        width: 0,
      ),
      child: PrayerTrackerItems(
        theme: theme,
        trackers: trackers,
        onTap: onTap,
      ),
    );
  }
}
