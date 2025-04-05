import 'package:flutter/material.dart';
import 'package:prayer_times/core/utility/utility.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      alignment: Alignment.centerRight,
      child: Switch(
        key: key,
        value: value,
        onChanged: onChanged,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeTrackColor: context.color.primaryColor900,
        inactiveThumbColor: context.color.whiteColor,
        inactiveTrackColor: context.color.blackColor100,
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
        trackOutlineWidth: const WidgetStatePropertyAll(0),
      ),
    );
  }
}
