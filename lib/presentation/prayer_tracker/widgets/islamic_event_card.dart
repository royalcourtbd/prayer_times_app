// lib/presentation/prayer_tracker/widgets/islamic_event_card.dart

import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/font_family.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';

class IslamicEventCard extends StatelessWidget {
  const IslamicEventCard({
    required this.date,
    required this.eventName,
    required this.eventType,
    required this.theme,
    super.key,
  });

  final String date;
  final String eventName;
  final String eventType;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DateText(
            date: date,
            theme: theme,
          ),
          gapH12,
          _EventDetails(
            eventName: eventName,
            eventType: eventType,
            theme: theme,
          ),
        ],
      ),
    );
  }
}

class _DateText extends StatelessWidget {
  const _DateText({
    required this.date,
    required this.theme,
  });

  final String date;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      date,
      style: theme.textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: fourteenPx,
      ),
    );
  }
}

class _EventDetails extends StatelessWidget {
  const _EventDetails({
    required this.eventName,
    required this.eventType,
    required this.theme,
  });

  final String eventName;
  final String eventType;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _EventIndicator(context: context),
        gapW16,
        _EventInfo(
          eventName: eventName,
          eventType: eventType,
          theme: theme,
          context: context,
        ),
      ],
    );
  }
}

class _EventIndicator extends StatelessWidget {
  const _EventIndicator({
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 2.percentWidth,
      backgroundColor: context.color.errorColor,
    );
  }
}

class _EventInfo extends StatelessWidget {
  const _EventInfo({
    required this.eventName,
    required this.eventType,
    required this.theme,
    required this.context,
  });

  final String eventName;
  final String eventType;
  final ThemeData theme;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventName,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: sixteenPx,
          ),
        ),
        gapH2,
        Text(
          eventType,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: fourteenPx,
            fontFamily: FontFamily.inter,
            color: context.color.errorColor,
          ),
        ),
      ],
    );
  }
}
