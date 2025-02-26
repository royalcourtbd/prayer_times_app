import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/data/models/prayer_tracker_model.dart';
import 'package:qibla_and_prayer_times/domain/entities/prayer_tracker_entity.dart';
import 'package:qibla_and_prayer_times/presentation/home/models/waqt.dart';

class PrayerTrackerItems extends StatelessWidget {
  const PrayerTrackerItems({
    super.key,
    required this.theme,
    required this.trackers,
    required this.onTap,
    this.itemHeight,
  });

  final ThemeData theme;
  final List<PrayerTrackerModel> trackers;
  final Function(WaqtType) onTap;
  final double? itemHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        trackers.length,
        (index) {
          final PrayerTrackerModel tracker = trackers[index];
          if (!tracker.type.shouldShowInTracker) {
            return const SizedBox.shrink();
          }
          return Expanded(
            child: InkWell(
              onTap: () => onTap(tracker.type),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Container(
                height: itemHeight ?? 21.percentWidth,
                margin: EdgeInsets.only(right: fivePx),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tracker.status != PrayerStatus.none
                      ? context.color.primaryColor
                      : context.color.whiteColor.withOpacityInt(0.5),
                  borderRadius: radius15,
                  border: Border.all(
                    color: tracker.status != PrayerStatus.none
                        ? Colors.transparent
                        : context.color.whiteColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgImage(
                      tracker.status != PrayerStatus.none
                          ? SvgPath.icCheckMark
                          : SvgPath.icUncheckMark,
                      width: twentyFivePx,
                      height: twentyFivePx,
                    ),
                    gapH15,
                    Text(
                      tracker.type.displayName,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: elevenPx,
                        fontWeight: FontWeight.normal,
                        color: tracker.status != PrayerStatus.none
                            ? context.color.whiteColor
                            : context.color.titleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
