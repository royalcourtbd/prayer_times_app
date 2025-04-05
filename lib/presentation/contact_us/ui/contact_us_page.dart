import 'package:flutter/material.dart';
import 'package:prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:prayer_times/core/di/service_locator.dart';
import 'package:prayer_times/core/external_libs/presentable_widget_builder.dart';
import 'package:prayer_times/core/external_libs/svg_image.dart';
import 'package:prayer_times/core/static/ui_const.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/domain/entities/social_link_entity.dart';
import 'package:prayer_times/presentation/common/custom_app_bar.dart';
import 'package:prayer_times/presentation/common/custom_card.dart';
import 'package:prayer_times/presentation/contact_us/presenter/contact_us_presenter.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({super.key});

  final ContactUsPresenter contactPresenter = locate<ContactUsPresenter>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PresentableWidgetBuilder(
        presenter: contactPresenter,
        builder: () {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Contact Us',
              theme: theme,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: padding15,
                child: Column(
                  children: [
                    CustomCard(
                      child: Column(
                        children: [
                          Text(
                            "We're building a platform to empower the Muslim Ummah and foster connections within our global community. We value your feedback and want to hear from you! Feel free to reach out using the methods below, and we'll get back to you as soon as possible.",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: context.color.subTitleColor,
                              height: 1.5,
                            ),
                          ),
                          gapH25,
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: tenPx,
                              crossAxisSpacing: tenPx,
                              childAspectRatio: 1.2 / 1,
                            ),
                            itemCount: contactPresenter
                                .currentUiState.socialLinks.length,
                            itemBuilder: (context, index) {
                              final SocialLinkEntity link = contactPresenter
                                  .currentUiState.socialLinks[index];
                              return _buildSocialLinkCard(
                                context: context,
                                theme: theme,
                                link: link,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildSocialLinkCard({
    required BuildContext context,
    required ThemeData theme,
    required SocialLinkEntity link,
  }) {
    return InkWell(
      onTap: () => link.onLinkClick(),
      borderRadius: radius10,
      child: Container(
        decoration: BoxDecoration(
          color: context.color.primaryColor50,
          borderRadius: radius10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImage(
              link.icon,
              color: context.color.primaryColor,
              width: twentyFivePx,
              height: twentyFivePx,
            ),
            gapH10,
            Text(
              link.title,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: context.color.titleColor,
                fontWeight: FontWeight.w400,
                fontSize: thirteenPx,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
