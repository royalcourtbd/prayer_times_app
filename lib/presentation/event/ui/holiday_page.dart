import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_text_input_field.dart';
import 'package:qibla_and_prayer_times/presentation/event/pesenter/event_presenter.dart';

class HolidayPage extends StatelessWidget {
  const HolidayPage({super.key, required this.eventPresenter});
  final EventPresenter eventPresenter;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PresentableWidgetBuilder(
        presenter: eventPresenter,
        builder: () {
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) {
              eventPresenter.clearSearchController();
            },
            child: Scaffold(
              appBar: CustomAppBar(theme: theme, title: 'Govt Holiday\'s 2025'),
              body: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(sixteenPx),
                    child: CustomTextInputField(
                      theme: theme,
                      controller: eventPresenter.searchController,
                      hintText: 'Search Holiday',
                      onChanged: eventPresenter.updateSearchQuery,
                    ),
                  ),
                  Expanded(
                    child: HolidayListView(
                      groupedEvents:
                          eventPresenter.currentUiState.groupedEvents,
                      theme: theme,
                      eventPresenter: eventPresenter,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class HolidayListView extends StatelessWidget {
  const HolidayListView({
    super.key,
    required this.groupedEvents,
    required this.theme,
    required this.eventPresenter,
  });

  final Map<String, List<EventModel>> groupedEvents;
  final ThemeData theme;
  final EventPresenter eventPresenter;

  @override
  Widget build(BuildContext context) {
    if (groupedEvents.isEmpty) {
      return const Center(
        child: Text('No Event\'s Found'),
      );
    }

    return ListView.builder(
      itemCount: groupedEvents.length,
      padding: EdgeInsets.symmetric(horizontal: sixteenPx),
      itemBuilder: (context, index) {
        final MapEntry<String, List<EventModel>> monthEntry =
            groupedEvents.entries.elementAt(index);
        return MonthEventsSection(
          month: monthEntry.key,
          events: monthEntry.value,
          theme: theme,
          eventPresenter: eventPresenter,
        );
      },
    );
  }
}

class MonthEventsSection extends StatelessWidget {
  const MonthEventsSection({
    super.key,
    required this.month,
    required this.events,
    required this.theme,
    required this.eventPresenter,
  });

  final String month;
  final List<EventModel> events;
  final ThemeData theme;
  final EventPresenter eventPresenter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MonthHeader(
          month: month,
          theme: theme,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: events.length,
          itemBuilder: (context, index) {
            return HolidayItem(
              event: events[index],
              eventPresenter: eventPresenter,
              theme: theme,
            );
          },
        ),
        gapH15,
      ],
    );
  }
}

class MonthHeader extends StatelessWidget {
  const MonthHeader({
    super.key,
    required this.month,
    required this.theme,
  });

  final String month;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: twelvePx),
      child: Text(
        month,
        style: theme.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: twelvePx,
          color: context.color.subTitleColor,
        ),
      ),
    );
  }
}

class HolidayItem extends StatelessWidget {
  const HolidayItem({
    super.key,
    required this.event,
    required this.eventPresenter,
    required this.theme,
  });

  final EventModel event;
  final EventPresenter eventPresenter;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final DateTime date = DateTime.parse(event.date);
    final String day = date.day.toString();

    return Container(
      margin: EdgeInsets.only(bottom: tenPx),
      decoration: BoxDecoration(
        color: event.color.withOpacityInt(0.1),
        borderRadius: radius20,
      ),
      child: Padding(
        padding: padding15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DateCircle(
              day: day,
              color: event.color,
              theme: theme,
            ),
            gapW12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: fourteenPx,
                    ),
                  ),
                  gapH4,
                  Text(
                    event.holidayType,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: event.color,
                      fontSize: twelvePx,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateCircle extends StatelessWidget {
  const DateCircle({
    super.key,
    required this.day,
    required this.color,
    required this.theme,
  });

  final String day;
  final Color color;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: fortyFourPx,
      width: fortyFourPx,
      decoration: BoxDecoration(color: color, borderRadius: radius14),
      child: Center(
        child: Text(
          day,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: context.color.whiteColor,
            fontWeight: FontWeight.w500,
            fontSize: fourteenPx,
          ),
        ),
      ),
    );
  }
}
