import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';

class PrayerTimeListItem extends StatelessWidget {
  const PrayerTimeListItem({
    super.key,
    required this.theme,
    required this.waqt,
  });

  final ThemeData theme;
  final WaqtViewModel waqt;
  String _getAmPm() {
    if (waqt.time == null) return '';
    return waqt.time!.hour < 12 ? 'am' : 'pm';
  }

  @override
  Widget build(BuildContext context) {
    final bool isSpecialIndex = waqt.type == WaqtType.maghrib;
    final TextStyle baseTextStyle = theme.textTheme.bodyMedium!;
    return Container(
      alignment: Alignment.center,
      width: isSpecialIndex ? 25.percentWidth : 43.percentWidth,
      padding: padding15,
      margin: EdgeInsets.only(right: twelvePx),
      decoration: BoxDecoration(
        color: waqt.isActive
            ? context.color.primaryColor
            : context.color.whiteColor.withOpacityInt(0.5),
        borderRadius: radius15,
        border: Border.all(
          color: waqt.isActive ? Colors.transparent : context.color.whiteColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isSpecialIndex
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isSpecialIndex
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              SvgImage(
                waqt.icon,
                height: twentyFourPx,
                width: twentyFourPx,
                color: waqt.isActive
                    ? context.color.whiteColor
                    : context.color.titleColor,
              ),
              if (!isSpecialIndex)
                SvgImage(
                  SvgPath.icVolumeHigh,
                  height: twentyFourPx,
                  width: twentyFourPx,
                ),
            ],
          ),
          Spacer(),
          Text(
            waqt.displayName,
            style: baseTextStyle.copyWith(
              fontSize: twelvePx,
              fontWeight: waqt.isActive ? FontWeight.w600 : FontWeight.normal,
              color: waqt.isActive
                  ? context.color.whiteColor
                  : context.color.titleColor,
            ),
          ),
          gapH3,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: waqt.formattedTime,
                  style: baseTextStyle.copyWith(
                    fontSize: fourteenPx,
                    fontWeight: FontWeight.w600,
                    color: waqt.isActive
                        ? context.color.whiteColor
                        : context.color.titleColor,
                  ),
                ),
                TextSpan(
                  text: ' ${_getAmPm()}',
                  style: baseTextStyle.copyWith(
                    fontSize: elevenPx,
                    color: waqt.isActive
                        ? context.color.whiteColor
                        : context.color.subTitleColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
