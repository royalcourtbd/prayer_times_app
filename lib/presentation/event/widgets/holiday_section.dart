import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/section_header_with_action.dart';
import 'package:qibla_and_prayer_times/presentation/event/widgets/govt_holiday_list.dart';

class HolidaySection extends StatelessWidget {
  const HolidaySection({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: twentyPx),
          child: SectionHeaderWithAction(
            title: 'Govt Holidays',
            actionText: 'See All',
            onActionTap: () {},
          ),
        ),
        gapH18,
        GovtHolidayList(theme: theme),
      ],
    );
  }
}
