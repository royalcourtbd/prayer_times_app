import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';

class CustomModalSheet extends StatelessWidget {
  const CustomModalSheet({
    super.key,
    required this.children,
    this.bottomSheetTitle,
    this.showPadding = true,
    this.constraints,
    required this.theme,
  });

  final List<Widget> children;
  final String? bottomSheetTitle;
  final bool showPadding;
  final BoxConstraints? constraints;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: constraints,
      padding: showPadding ? padding20 : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: context.color.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(twentyPx),
          topRight: Radius.circular(twentyPx),
        ),
      ),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showPadding ? const SizedBox.shrink() : gapH20,
              if (bottomSheetTitle != null) ...[
                Center(
                  child: Text(
                    bottomSheetTitle!,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: sixteenPx,
                      fontWeight: FontWeight.w600,
                      color: context.color.titleColor,
                    ),
                  ),
                ),
                gapH20,
              ],
              ...children,
            ],
          )
        ],
      ),
    );
  }
}
