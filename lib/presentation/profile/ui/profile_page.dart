import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar_title.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
import 'package:qibla_and_prayer_times/presentation/profile/widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomAppBarTitle(
          title: 'Profile',
        ),
      ),
      body: Padding(
        padding: padding15,
        child: CustomCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileMenuItem(
                icon: SvgPath.icSettingsOutline,
                title: 'Settings',
                onTap: () {
                  log('Settings');
                },
              ),
              gapH20,
              ProfileMenuItem(
                icon: SvgPath.icShare,
                title: 'Share',
                onTap: () {
                  log('Share');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
