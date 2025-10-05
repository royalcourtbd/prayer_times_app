import 'package:flutter/material.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.border,
  });
  final Widget child;
  final Color? backgroundColor;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding15,
      width: double.infinity,
      decoration: BoxDecoration(
        color:
            backgroundColor ?? context.color.primaryColor.withOpacityInt(0.05),
        borderRadius: radius18,
        border: border ??
            Border.all(
              color: context.color.primaryColor.withOpacityInt(0.1),
              width: 1,
            ),
      ),
      child: child,
    );
  }
}
