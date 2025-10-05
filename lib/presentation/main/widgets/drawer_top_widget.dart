import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/static/svg_path.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';

class DrawerTopWidget extends StatelessWidget {
  const DrawerTopWidget({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('menu_drawer_bottom_sheet_container'),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: twentyPx,
      ),
      decoration: BoxDecoration(
          // color: context.color.primaryColor200,
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: tenPx,
        children: [
          ClipRRect(
            borderRadius: radius20,
            child: Image.asset(
              SvgPath.appLogo,
              width: 22.percentWidth,
              height: 22.percentWidth,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Prayer Times',
                style: theme.textTheme.titleMedium!.copyWith(
                  fontSize: twentyTwoPx,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gapW10,
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: tenPx, vertical: fivePx),
                decoration: BoxDecoration(
                  color: context.color.primaryColor50,
                  borderRadius: radius20,
                ),
                child: FutureBuilder(
                  future: currentAppVersion,
                  builder: (context, snapshot) {
                    return Text(
                      'v${snapshot.data}',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: tenPx,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          Text(
            'Precise Qibla Direction & Prayer Times,\nAnytime, Anywhere',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium!.copyWith(
              fontSize: twelvePx,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
