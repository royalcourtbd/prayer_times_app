import 'package:flutter/material.dart';
import 'package:salat_times/core/config/prayer_time_app_screen.dart';
import 'package:salat_times/core/static/ui_const.dart';
import 'package:salat_times/core/utility/utility.dart';

class RoundedTopContainer extends StatelessWidget {
  final List<Widget> children;

  const RoundedTopContainer({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding20,
      decoration: BoxDecoration(
        color: Colors.white.withOpacityInt(0.5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(thirtyPx)),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
