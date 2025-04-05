import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/external_libs/svg_image.dart';
import 'package:prayer_times/core/static/font_family.dart';
import 'package:prayer_times/core/static/svg_path.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/presentation/home/presenter/home_presenter.dart';

class ClockSection extends StatelessWidget {
  const ClockSection({
    super.key,
    required this.theme,
    required this.presenter,
  });

  final ThemeData theme;
  final HomePresenter presenter;

  String _getAmPm() {
    final DateTime now = presenter.currentUiState.nowTime ?? DateTime.now();
    return now.hour < 12 ? 'am' : 'pm';
  }

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
          RepaintBoundary(
            key: Key('clock_section'),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  presenter.getCurrentTime(),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: fiftyFivePx,
                    fontFamily: FontFamily.bigShouldersText,
                    height: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _getAmPm(),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: fifteenPx,
                    color: context.color.subTitleColor,
                    fontFamily: FontFamily.bigShouldersText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
