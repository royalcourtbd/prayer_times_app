import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';
import 'package:qibla_and_prayer_times/presentation/common/circle_icon_widget.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
import 'package:qibla_and_prayer_times/presentation/common/widgets/prayer_tracker_items.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';

class PrayerTrackerWidget extends StatelessWidget {
  const PrayerTrackerWidget({
    super.key,
    required this.theme,
    required this.trackers,
    required this.onTap,
    this.showNavigationArrow = false,
    this.onPreviousTap,
    this.onNextTap,
  });

  final ThemeData theme;
  final List<PrayerTrackerModel> trackers;
  final Function(WaqtType) onTap;
  final bool showNavigationArrow;
  final VoidCallback? onPreviousTap;
  final VoidCallback? onNextTap;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Row(
            children: [
              SvgImage(
                SvgPath.icCrown,
                color: context.color.primaryColor,
              ),
              gapW10,
              Text(
                'Prayer Tracker',
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: fifteenPx,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (showNavigationArrow) ...[
                RotatedBox(
                  quarterTurns: 2,
                  child: CircleIconWidget(
                    size: fortyPx,
                    icon: SvgPath.icArrowRight,
                    onTap: onPreviousTap,
                  ),
                ),
                gapW16,
                CircleIconWidget(
                  size: fortyPx,
                  icon: SvgPath.icArrowRight,
                  onTap: onNextTap,
                ),
              ]
            ],
          ),
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
}
