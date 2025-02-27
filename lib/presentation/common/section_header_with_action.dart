import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class SectionHeaderWithAction extends StatelessWidget {
  const SectionHeaderWithAction({
    super.key,
    required this.title,
    required this.actionText,
    required this.onActionTap,
  });

  final String title;
  final String actionText;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium!.copyWith(
            fontSize: fifteenPx,
            fontWeight: FontWeight.w600,
          ),
        ),
        InkWell(
          onTap: onActionTap,
          child: Text(
            actionText,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: twelvePx,
              fontWeight: FontWeight.normal,
              color: context.color.subTitleColor,
            ),
          ),
        ),
      ],
    );
  }
}
