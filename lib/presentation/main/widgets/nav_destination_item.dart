import 'package:flutter/material.dart';
import 'package:salat_times/core/external_libs/svg_image.dart';

class NavDestinationItem extends StatelessWidget {
  const NavDestinationItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.outlineIcon,
    required this.fillIcon,
    required this.label,
  });

  final int index;
  final int selectedIndex;
  final String outlineIcon;
  final String fillIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: SvgImage(selectedIndex == index ? fillIcon : outlineIcon),
      label: label,
      tooltip: '',
    );
  }
}
