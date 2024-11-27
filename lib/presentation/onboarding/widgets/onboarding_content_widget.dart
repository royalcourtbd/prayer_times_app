import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/static/ui_const.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/onboarding_content_entity.dart';
import 'package:qibla_and_prayer_times/presentation/onboarding/presenter/onboarding_ui_state.dart';
import 'package:qibla_and_prayer_times/presentation/onboarding/widgets/custom_page_indicator.dart';

class OnboardingContentWidget extends StatelessWidget {
  const OnboardingContentWidget({
    super.key,
    required this.content,
    required this.theme,
  });

  final OnboardingContentEntity content;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          content.image,
          height: 105.percentWidth,
        ),
        gapH30,
        CustomPageIndicator(
          currentIndex: content.index,
          itemCount: onboardingPages.length,
          activeWidth: thirtyPx,
          inactiveWidth: eightPx,
          height: eightPx,
          spacing: eightPx,
        ),
        gapH40,
        Text(
          content.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: twentyFourPx,
          ),
        ),
        gapH16,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: twentyFourPx),
          child: Text(
            content.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: context.color.subTitleColor,
              fontSize: sixteenPx,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
