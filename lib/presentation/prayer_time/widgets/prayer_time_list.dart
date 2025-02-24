import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/presentation/prayer_time/widgets/prayer_time_list_item.dart';

class PrayerTimeList extends StatelessWidget {
  const PrayerTimeList({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: twentyPx),
        itemBuilder: (context, index) {
          return PrayerTimeListItem(theme: theme, index: index);
        },
      ),
    );
  }
}
