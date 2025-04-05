import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/presentation/common/section_header_with_action.dart';
import 'package:prayer_times/presentation/event/pesenter/event_presenter.dart';
import 'package:prayer_times/presentation/event/ui/holiday_page.dart';
import 'package:prayer_times/presentation/event/widgets/govt_holiday_list.dart';

class HolidaySection extends StatelessWidget {
  const HolidaySection({
    super.key,
    required this.theme,
    required this.eventPresenter,
  });

  final ThemeData theme;
  final EventPresenter eventPresenter;

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
            onActionTap: () => context
                .navigatorPush(HolidayPage(eventPresenter: eventPresenter)),
          ),
        ),
        gapH18,
        GovtHolidayList(theme: theme),
      ],
    );
  }
}
