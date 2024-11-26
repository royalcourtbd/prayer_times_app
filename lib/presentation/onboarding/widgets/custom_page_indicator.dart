import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CustomPageIndicator extends StatelessWidget {
  const CustomPageIndicator({
    required this.currentIndex,
    required this.itemCount,
    required this.activeWidth,
    required this.inactiveWidth,
    required this.height,
    required this.spacing,
    this.radius,
    super.key,
  });

  final int currentIndex;
  final int itemCount;
  final double activeWidth;
  final double inactiveWidth;
  final double height;
  final double spacing;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          margin: EdgeInsets.only(right: index != itemCount - 1 ? spacing : 0),
          height: height,
          width: currentIndex == index ? activeWidth : inactiveWidth,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? context.color.primaryColor
                : context.color.primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(radius ?? fivePx),
          ),
        ),
      ),
    );
  }
}
