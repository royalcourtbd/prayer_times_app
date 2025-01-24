import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/di/service_locator.dart';
import 'package:qibla_and_prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_app_bar_title.dart';
import 'package:qibla_and_prayer_times/presentation/common/custom_card.dart';
import 'package:qibla_and_prayer_times/presentation/profile/presenter/profile_page_presenter.dart';
import 'package:qibla_and_prayer_times/presentation/profile/widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final ProfilePagePresenter profilePresenter = locate<ProfilePagePresenter>();

  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);
    profilePresenter.updateContext(context);
    return PresentableWidgetBuilder(
        presenter: profilePresenter,
        builder: () {
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
                      onTap: () => profilePresenter.onSettingsTap(),
                    ),
                    gapH20,
                    ProfileMenuItem(
                      icon: SvgPath.icSettingsOutline,
                      title: 'About This App',
                      onTap: () {},
                    ),
                    gapH20,
                    ProfileMenuItem(
                      icon: SvgPath.icSettingsOutline,
                      title: 'Contact Us',
                      onTap: () {},
                    ),
                    gapH20,
                    ProfileMenuItem(
                      icon: SvgPath.icSettingsOutline,
                      title: 'Report a Bug',
                      onTap: () {},
                    ),
                    gapH20,
                    ProfileMenuItem(
                      icon: SvgPath.icSettingsOutline,
                      title: 'Notification',
                      onTap: () {},
                    ),
                    gapH20,
                    ProfileMenuItem(
                      icon: SvgPath.icSettingsOutline,
                      title: 'Rate This App',
                      onTap: () {},
                    ),
                    gapH20,
                    ProfileMenuItem(
                      icon: SvgPath.icShare,
                      title: 'Share',
                      onTap: profilePresenter.onShareAppTap,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
