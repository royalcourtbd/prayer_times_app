import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
    this.padding,
    this.color,
  });
  final Widget? child;
  final EdgeInsets? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? padding12,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? context.color.whiteColor,
        borderRadius: radius18,
      ),
      child: child,
    );
  }
}
