import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';
import 'package:salat_times/presentation/common/custom_button.dart';

class NotificationDeniedDialog extends StatelessWidget {
  const NotificationDeniedDialog({
    super.key,
    required this.onSubmit,
  });

  final Future<void> Function() onSubmit;

  static Future<void> show({
    required BuildContext context,
    required Future<void> Function() onSubmit,
  }) async {
    await showAnimatedDialog<void>(
      context: context,
      builder: (_) => NotificationDeniedDialog(onSubmit: onSubmit),
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: twentyPx),
      elevation: 0,
      backgroundColor: isDarkMode(context) ? theme.cardColor : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: radius20),
      child: Container(
        padding: padding20,
        decoration: BoxDecoration(
          borderRadius: radius10,
        ),
        height: 80.percentWidth,
        child: ClipRRect(
          borderRadius: radius12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 18.percentWidth),
              Text(
                'Notification Denied!',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
              gapH10,
              Text(
                'Please enable notification permission to receive important updates.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium!.copyWith(),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    title: 'Cancel',
                    onPressed: () => context.navigatorPop<void>(),
                    width: 35.percentWidth,
                    horizontalPadding: 0,
                    isPrimary: false,
                  ),
                  gapW10,
                  CustomButton(
                    title: 'Open Settings',
                    horizontalPadding: 0,
                    onPressed: () async {
                      if (context.mounted) context.navigatorPop<void>();

                      await onSubmit();
                    },
                    width: 35.percentWidth,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
