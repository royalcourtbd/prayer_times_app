import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/utility/utility.dart';

class SkipButtonWidget extends StatelessWidget {
  const SkipButtonWidget({
    required this.onTap,
    required this.theme,
    super.key,
  });

  final VoidCallback onTap;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15.percentWidth,
      right: twentyPx,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Row(
          children: [
            Text(
              'Skip',
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: fourteenPx,
                fontWeight: FontWeight.w400,
                color: context.color.subTitleColor,
              ),
            ),
            gapW5,
            Icon(
              Icons.arrow_forward,
              size: sixteenPx,
              color: context.color.subTitleColor,
            ),
          ],
        ),
      ),
    );
  }
}
