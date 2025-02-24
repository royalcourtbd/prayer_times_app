import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/font_family.dart';
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
              SvgImage(
                SvgPath.icLocation,
                height: twentyPx,
                width: twentyPx,
              ),
              gapW5,
              Expanded(
                child: Text(
                  'Dhaka, Bangladesh',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: thirteenPx,
                    fontFamily: FontFamily.poppins,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            'Ramadan 17, 1444',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: thirteenPx,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapH3,
          Text(
            'July 20, 2025',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
