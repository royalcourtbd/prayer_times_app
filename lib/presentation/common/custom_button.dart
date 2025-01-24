import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/external_libs/svg_image.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    required this.onPressed,
    this.isPrimary = true,
    this.horizontalPadding,
    this.iconPath,
    super.key,
  });

  final String title;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double? horizontalPadding;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? twentyPx),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: fiftyPx,
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isPrimary ? theme.colorScheme.primary : Colors.transparent,
            border: isPrimary
                ? null
                : Border.all(color: context.color.primaryColor300),
            borderRadius: BorderRadius.circular(twentySevenPx),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null) ...[
                SvgImage(iconPath!),
                gapW10,
              ],
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: fourteenPx,
                  color: isPrimary
                      ? context.color.buttonColor
                      : context.color.buttonBgColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
