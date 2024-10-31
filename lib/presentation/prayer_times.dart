import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:qibla_and_prayer_times/core/config/themes.dart';
import 'package:qibla_and_prayer_times/presentation/main/ui/main_page.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class PrayerTimes extends StatelessWidget {
  const PrayerTimes({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get globalContext =>
      navigatorKey.currentContext ?? Get.context!;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: PrayerTimeTheme.lightTheme,
          title: 'Prayer Times',
          home: MainPage(),
        );
      },
    );
  }
}
