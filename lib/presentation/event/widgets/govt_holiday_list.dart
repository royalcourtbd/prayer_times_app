import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/presentation/event/pesenter/event_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/event/widgets/govt_holiday_list_item.dart';

class GovtHolidayList extends StatelessWidget {
  const GovtHolidayList({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.percentWidth,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: eventList.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: twentyPx),
        itemBuilder: (context, index) {
          final EventModel event = eventList[index];
          return GovtHolidayListItem(
            theme: theme,
            event: event,
            isLastItem: index == eventList.length - 1,
          );
        },
      ),
    );
  }
}
