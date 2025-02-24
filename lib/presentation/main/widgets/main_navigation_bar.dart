import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/presentation/main/widgets/nav_destination_item.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sixteenPx),
      decoration: BoxDecoration(
        color: context.color.backgroundColor,
        border: Border(
          top: BorderSide(
            color: context.color.blackColor200,
          ),
        ),
      ),
      child: NavigationBar(
        backgroundColor: context.color.backgroundColor,
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: [
          NavDestinationItem(
            index: 0,
            selectedIndex: selectedIndex,
            outlineIcon: SvgPath.icHomeOutline,
            fillIcon: SvgPath.icHomeFill,
            label: 'Home',
          ),
          NavDestinationItem(
            index: 1,
            selectedIndex: selectedIndex,
            outlineIcon: SvgPath.icCategoryOutline,
            fillIcon: SvgPath.icCategoryFill,
            label: 'Tracker',
          ),
          NavDestinationItem(
            index: 2,
            selectedIndex: selectedIndex,
            outlineIcon: SvgPath.icCalenderOutline,
            fillIcon: SvgPath.icCalenderFill,
            label: 'Events',
          ),
          NavDestinationItem(
            index: 3,
            selectedIndex: selectedIndex,
            outlineIcon: SvgPath.icMusicOutlin,
            fillIcon: SvgPath.icMusicFill,
            label: 'Audio',
          ),
          NavDestinationItem(
            index: 4,
            selectedIndex: selectedIndex,
            outlineIcon: SvgPath.icProfileOutline,
            fillIcon: SvgPath.icProfileFill,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
