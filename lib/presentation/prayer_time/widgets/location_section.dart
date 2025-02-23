import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({
    super.key,
    required this.theme,
    required this.onBuildContainer,
  });

  final ThemeData theme;
  final Widget Function({
    required BuildContext context,
    required ThemeData theme,
    required Widget child,
  }) onBuildContainer;

  @override
  Widget build(BuildContext context) {
    return onBuildContainer(
      context: context,
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgImage(SvgPath.icLocation),
              gapW5,
              Expanded(
                child: Text(
                  'Dhaka, Bangladesh',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: thirteenPx,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          gapH12,
          Text(
            'Ramadan 17, 1444',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: fifteenPx,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapH3,
          Text(
            'July 20, 2025',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: thirteenPx,
              color: context.color.subTitleColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
