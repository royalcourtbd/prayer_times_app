import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/prayer_time_page_app_bar.dart';

class PrayerTimePage extends StatelessWidget {
  const PrayerTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: HomePageAppBar(
        theme: theme,
        onTapNotification: () =>
            showMessage(context: context, message: 'Notification'),
      ),
      body: Padding(
        padding: padding15,
        child: Column(
          children: [
            Container(
              padding: padding15,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.color.backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '28 Rabiu Awal, 1445 H',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: context.color.titleColor,
                      fontSize: fourteenPx,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  gapH5,
                  Text(
                    '15:30',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: context.color.titleColor,
                      fontSize: thirtyNinePx,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  gapH16,
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Remaining Asr  ',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: context.color.titleColor,
                            fontSize: twelvePx,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '02:30:32',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: context.color.primaryColor600,
                            fontSize: twelvePx,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapH10,
                  Stack(
                    children: [
                      Container(
                        height: ninePx,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: context.color.primaryColor25,
                          borderRadius: radius10,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: ninePx,
                        width: 200,
                        decoration: BoxDecoration(
                          color: context.color.primaryColor900,
                          borderRadius: radius10,
                        ),
                      ),
                    ],
                  ),
                  gapH25,
                  Row(
                    children: List.generate(
                      5,
                      (index) {
                        return Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: fourPx, vertical: eightPx),
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
                  ),
                  gapH25,
                  Text(
                    'Notify Me',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: context.color.titleColor,
                      fontSize: fourteenPx,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  gapH3,
                  Row(
                    children: [
                      Text(
                        'Notify me every prayer time',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: context.color.subTitleColor,
                          fontSize: twelvePx,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
