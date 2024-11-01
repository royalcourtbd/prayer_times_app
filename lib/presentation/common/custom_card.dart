import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding15,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.color.backgroundColor,
        borderRadius: radius10,
      ),
      child: child,
    );
  }
}
