import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor,
  });
  final Widget child;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding15,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.color.backgroundColor,
        borderRadius: radius12,
      ),
      child: child,
    );
  }
}
