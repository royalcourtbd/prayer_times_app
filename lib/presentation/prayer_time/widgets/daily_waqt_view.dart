import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/models/waqt.dart';

class DailyWaqtView extends StatelessWidget {
  const DailyWaqtView({
    super.key,
    required this.theme,
    required this.waqtList,
  });

  final ThemeData theme;
  final List<WaqtViewModel> waqtList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        waqtList.length,
        (index) {
          final WaqtViewModel waqt = waqtList[index];
          return Expanded(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: fourPx, vertical: eightPx),
              decoration: BoxDecoration(
                borderRadius: radius10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    waqt.displayName,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: context.color.titleColor,
                      fontSize: fourteenPx,
                      fontWeight:
                          waqt.isActive ? FontWeight.w600 : FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis, // Add this
                    softWrap: false, // Add this
                  ),
                  gapH12,
                  SvgImage(
                    waqt.isActive
                        ? waqt.icon
                        : waqt.icon.replaceAll('fill', 'outline'),
                    width: twentyFourPx,
                    height: twentyFourPx,
                    color: waqt.isActive
                        ? context.color.primaryColor
                        : context.color.titleColor,
                  ),
                  gapH12,
                  Text(
                    waqt.formattedTime,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: context.color.titleColor,
                      fontSize: fourteenPx,
                      height: 1.3,
                      fontWeight:
                          waqt.isActive ? FontWeight.w600 : FontWeight.w500,
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
}
