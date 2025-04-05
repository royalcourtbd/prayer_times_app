import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/external_libs/flutter_animated_dialog/src/animated_dialog.dart';
import 'package:prayer_times/core/static/svg_path.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/presentation/common/custom_button.dart';

class RemoveDialog extends StatelessWidget {
  const RemoveDialog({
    super.key,
    required this.title,
    required this.onRemove,
  });

  final String title;
  final Future<void> Function() onRemove;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required Future<void> Function() onRemove,
  }) async {
    await showAnimatedDialog<void>(
      context: context,
      builder: (_) => RemoveDialog(
        onRemove: onRemove,
        title: title,
      ),
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
        decoration: BoxDecoration(
          borderRadius: radius10,
        ),
        height: 80.percentWidth,
        child: ClipRRect(
          borderRadius: radius12,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60.percentWidth,
                  child: SvgPicture.asset(
                    SvgPath.dicBG,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: twentyPx),
                  child: SvgPicture.asset(
                    SvgPath.icDelete,
                    fit: BoxFit.cover,
                    height: 25.percentWidth,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Delete',
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: padding15,
                      child: Text(
                        'You Will Not be able to recover this history',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: context.color.subTitleColor,
                          height: 1.8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    gapH15,
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
                          title: title,
                          horizontalPadding: 0,
                          onPressed: () async {
                            if (context.mounted) context.navigatorPop<void>();

                            await onRemove();
                          },
                          width: 35.percentWidth,
                        ),
                      ],
                    ),
                    gapH20,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
