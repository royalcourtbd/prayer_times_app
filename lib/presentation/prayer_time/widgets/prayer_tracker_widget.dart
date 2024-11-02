import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/circle_icon_widget.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/prayer_tracker.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';

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
                trackers.length,
                (index) {
                  final tracker = trackers[index];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTap(tracker.type),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: eightPx),
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
                                      color:
                                          (tracker.status != PrayerStatus.none)
                                              ? context.color.primaryColor900
                                              : context.color.primaryColor500,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                if (tracker.status != PrayerStatus.none)
                                  Container(
                                    width: 3.percentWidth,
                                    height: 3.percentWidth,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.color.primaryColor900,
                                    ),
                                  ),
                              ],
                            ),
                            gapH12,
                            Text(
                              tracker.type.displayName,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: context.color.titleColor,
                                fontSize: fourteenPx,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
