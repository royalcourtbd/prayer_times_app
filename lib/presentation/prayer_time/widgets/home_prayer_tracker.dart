import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class HomePrayerTracker extends StatelessWidget {
  const HomePrayerTracker({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

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
          _buildTrackerItem(context),
        ],
      ),
    );
  }

  Row _buildTrackerItem(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) {
          final bool isSpecialIndex = index == 1;
          return Expanded(
            child: Container(
              height: 22.percentWidth,
              margin: EdgeInsets.only(right: fivePx),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSpecialIndex
                    ? context.color.primaryColor
                    : context.color.whiteColor.withOpacityInt(0.5),
                borderRadius: radius15,
                border: Border.all(
                  color: isSpecialIndex
                      ? Colors.transparent
                      : context.color.whiteColor,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgImage(
                    isSpecialIndex
                        ? SvgPath.icCheckMark
                        : SvgPath.icUncheckMark,
                    width: twentyFivePx,
                    height: twentyFivePx,
                  ),
                  gapH15,
                  Text(
                    _getPrayerNames()[index],
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: twelvePx,
                      fontWeight: FontWeight.normal,
                      color: isSpecialIndex
                          ? context.color.whiteColor
                          : context.color.titleColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
            fontSize: thirteenPx,
            fontWeight: FontWeight.normal,
            color: context.color.subTitleColor,
          ),
        ),
      ],
    );
  }
}

List<String> _getPrayerNames() {
  return [
    'Fajr',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];
}
