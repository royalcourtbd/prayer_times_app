import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/home_page_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/clock_section.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/location_section.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/prayer_time_list.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/remaining_prayer_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(SvgPath.appBgJpg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: HomePageAppBar(theme: theme),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: padding20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClockSection(theme: theme),
                  gapW12,
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LocationSection(
                          theme: theme,
                          onBuildContainer: _buildContainer,
                        ),
                        gapH10,
                        RemainingPrayerSection(
                          theme: theme,
                          onBuildContainer: _buildContainer,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            gapH10,
            PrayerTimeList(theme: theme),
            gapH20,
            Expanded(
              child: Container(
                width: double.infinity,
                padding: padding20,
                decoration: BoxDecoration(
                  color: context.color.whiteColor.withOpacityInt(0.5),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(thirtyPx)),
                  border: Border.all(
                    color: context.color.whiteColor,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: padding15,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.color.primaryColor.withOpacityInt(0.07),
                        borderRadius: radius18,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Prayer Tracker',
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontSize: fifteenPx,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'See All',
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontSize: thirteenPx,
                                  fontWeight: FontWeight.normal,
                                  color: context.color.subTitleColor,
                                ),
                              ),
                            ],
                          ),
                          gapH10,
                          Row(
                            children: List.generate(
                              5,
                              (index) {
                                return Expanded(
                                  child: Container(
                                    padding: padding4,
                                    height: 22.percentWidth,
                                    margin: EdgeInsets.only(right: fivePx),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: index == 1
                                          ? context.color.primaryColor
                                          : context.color.whiteColor
                                              .withOpacityInt(0.5),
                                      borderRadius: radius15,
                                      border: Border.all(
                                        color: context.color.whiteColor,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgImage(
                                          index == 1
                                              ? SvgPath.icCheckMark
                                              : SvgPath.icUncheckMark,
                                          width: twentyFivePx,
                                          height: twentyFivePx,
                                        ),
                                        gapH15,
                                        Text('Asr'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildContainer({
    required BuildContext context,
    required ThemeData theme,
    required Widget child,
  }) {
    return Container(
      padding: padding10,
      alignment: Alignment.center,
      height: 98,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.color.whiteColor.withOpacityInt(0.5),
        borderRadius: BorderRadius.circular(fourteenPx),
      ),
      child: child,
    );
  }
}
