import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/external_libs/animate_do/fades.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';

class CircleStatusIndicator extends StatelessWidget {
  const CircleStatusIndicator({
    required this.isSelected,
    required this.size,
    required this.innerCircleSize,
    this.selectedBorderColor,
    this.unselectedBorderColor,
    this.selectedFillColor,
    this.borderWidth = 2.0,
    super.key,
  });

  final bool isSelected;
  final double size;
  final double innerCircleSize;
  final Color? selectedBorderColor;
  final Color? unselectedBorderColor;
  final Color? selectedFillColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? context.color.primaryColor50 : null,
            border: Border.all(
              color: isSelected
                  ? selectedBorderColor ?? context.color.primaryColor
                  : unselectedBorderColor ?? context.color.subTitleColor,
              width: borderWidth,
            ),
          ),
        ),
        if (isSelected)
          FadeIn(
            child: Container(
              width: innerCircleSize,
              height: innerCircleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedFillColor ?? context.color.primaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
