import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class ClockSection extends StatelessWidget {
  const ClockSection({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 57.percentWidth,
            child: SvgImage(
              SvgPath.imgClockBg,
              width: 110.percentWidth,
              height: 110.percentWidth,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '02:56',
                style: GoogleFonts.bigShouldersText(
                  fontSize: fiftyFivePx,
                  height: 1,
                ),
              ),
              Text(
                'AM',
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: fourteenPx,
                  color: context.color.subTitleColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
