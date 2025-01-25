import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding12,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.color.whiteColor,
        borderRadius: radius18,
      ),
      child: child,
    );
  }
}
