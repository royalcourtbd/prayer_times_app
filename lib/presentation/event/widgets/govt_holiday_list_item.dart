import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/presentation/event/pesenter/event_presenter.dart';

class GovtHolidayListItem extends StatelessWidget {
  const GovtHolidayListItem({
    super.key,
    required this.theme,
    required this.event,
    this.isLastItem = false,
  });

  final ThemeData theme;
  final EventModel event;
  final bool isLastItem;

  String _getDisplayDate(DateTime eventDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDay = DateTime(eventDate.year, eventDate.month, eventDate.day);

    if (eventDay == today) {
      return 'Today';
    }
    return getFormattedDate(eventDate);
  }

  @override
  Widget build(BuildContext context) {
    final maxWidthConstraint = BoxConstraints(maxWidth: 50.percentWidth);
    return Container(
      width: 55.percentWidth,
      alignment: Alignment.centerLeft,
      padding: padding15,
      margin: EdgeInsets.only(right: isLastItem ? twentyPx : twelvePx),
      decoration: BoxDecoration(
        color: event.color.withOpacityInt(0.1),
        borderRadius: radius15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: padding10,
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: radius12,
            ),
            child: Text(
              _getDisplayDate(DateTime.parse(event.date)),
              style: theme.textTheme.bodyMedium!.copyWith(
                color: context.color.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: elevenPx,
                height: 1,
              ),
            ),
          ),
          Spacer(),
          ConstrainedBox(
            constraints: maxWidthConstraint,
            child: Text(
              event.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: fourteenPx,
              ),
            ),
          ),
          gapH5,
          ConstrainedBox(
            constraints: maxWidthConstraint,
            child: Text(
              event.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: twelvePx,
                color: event.color,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
