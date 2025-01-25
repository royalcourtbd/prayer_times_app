import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_presenter.dart';
import 'package:qibla_and_prayer_times/core/static/svg_path.dart';
import 'package:qibla_and_prayer_times/core/utility/utility.dart';
import 'package:qibla_and_prayer_times/domain/entities/social_link_entity.dart';
import 'package:qibla_and_prayer_times/presentation/contact_us/presenter/contact_us_ui_state.dart';

class ContactUsPresenter extends BasePresenter<ContactUsUiState> {
  final Obs<ContactUsUiState> uiState = Obs(ContactUsUiState.empty());
  ContactUsUiState get currentUiState => uiState.value;

  @override
  void onInit() {
    _loadSocialLinks();
    super.onInit();
  }

  void _loadSocialLinks() {
    final List<SocialLinkEntity> links = [
      const SocialLinkEntity(
        title: 'Official Page',
        icon: SvgPath.icFacebook,
        url: 'https://facebook.com/royalcourtbd',
      ),
      const SocialLinkEntity(
        title: 'User Group',
        icon: SvgPath.icUserProfile,
        url: 'https://facebook.com/groups/royalcourtbd',
      ),
      const SocialLinkEntity(
        title: 'Twitter (X)',
        icon: SvgPath.icTwitter,
        url: 'https://twitter.com/royalcourtbd',
      ),
      const SocialLinkEntity(
        title: 'Youtube',
        icon: SvgPath.icCategoryFill,
        url: 'https://youtube.com/@royalcourtbd',
      ),
      const SocialLinkEntity(
        title: 'Linkedin',
        icon: SvgPath.icLinkedin,
        url: 'https://linkedin.com/company/royalcourtbd',
      ),
      const SocialLinkEntity(
        title: 'Website',
        icon: SvgPath.icGlobalSearch,
        url: 'https://royalcourtbd.com',
      ),
    ];

    uiState.value = currentUiState.copyWith(socialLinks: links);
  }

  Future<void> onSocialLinkTap(String url) async {
    await openUrl(url: url, context: currentUiState.context!);
  }

  void updateContext(BuildContext context) {
    uiState.value = currentUiState.copyWith(context: context);
  }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(
      message: currentUiState.userMessage,
      context: currentUiState.context,
    );
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
