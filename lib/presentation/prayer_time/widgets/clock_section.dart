import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
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
            height: 54.percentWidth,
            child: Image.asset(
              SvgPath.imgClockBg,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '02:56',
                style: GoogleFonts.bigShouldersText(
                  fontSize: sixtyFivePx,
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
