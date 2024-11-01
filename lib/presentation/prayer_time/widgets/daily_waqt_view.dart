import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class DailyWaqtView extends StatelessWidget {
  const DailyWaqtView({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) {
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
                    'Test',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: context.color.titleColor,
                      fontSize: fourteenPx,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis, // Add this
                    softWrap: false, // Add this
                  ),
                  gapH12,
                  SvgImage(
                    SvgPath.icAsrFill,
                    width: twentyFourPx,
                    height: twentyFourPx,
                  ),
                  gapH12,
                  Text(
                    '15:30',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: context.color.titleColor,
                      fontSize: fourteenPx,
                      fontWeight: FontWeight.w500,
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
