import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class PrayerTimeListItem extends StatelessWidget {
  const PrayerTimeListItem({
    super.key,
    required this.theme,
    required this.index,
  });

  final ThemeData theme;
  final int index;
  @override
  Widget build(BuildContext context) {
    final bool isSpecialIndex = index == 1;
    final TextStyle baseTextStyle = theme.textTheme.bodyMedium!;
    return Container(
      alignment: Alignment.center,
      width: isSpecialIndex ? 25.percentWidth : 43.percentWidth,
      padding: padding15,
      margin: EdgeInsets.only(right: twelvePx),
      decoration: BoxDecoration(
        color: context.color.whiteColor.withOpacityInt(0.5),
        borderRadius: radius15,
        border: Border.all(
          color: context.color.whiteColor,
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
                SvgPath.icFazrFill,
                height: twentyFourPx,
                width: twentyFourPx,
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
            'Maghrib',
            style: baseTextStyle.copyWith(
              fontSize: twelvePx,
              fontWeight: FontWeight.normal,
            ),
          ),
          gapH4,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '4:50',
                  style: baseTextStyle.copyWith(
                    fontSize: fourteenPx,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' am',
                  style: baseTextStyle.copyWith(
                    fontSize: elevenPx,
                    color: context.color.subTitleColor,
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
