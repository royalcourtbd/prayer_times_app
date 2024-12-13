import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/common/circle_status_indicator.dart';

class CustomRadioListTile extends StatelessWidget {
  const CustomRadioListTile({
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: tenPx,
        ),
        child: Row(
          children: [
            CircleStatusIndicator(
              isSelected: isSelected,
              size: 7.percentWidth,
              innerCircleSize: 2.5.percentWidth,
            ),
            gapW16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: fourteenPx,
                      fontWeight: FontWeight.w500,
                      color: context.color.titleColor,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    gapH2,
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: fourteenPx,
                        fontWeight: FontWeight.w400,
                        color: context.color.subTitleColor,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
