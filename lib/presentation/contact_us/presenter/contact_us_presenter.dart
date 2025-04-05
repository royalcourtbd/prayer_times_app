import 'package:prayer_times/core/base/base_presenter.dart';
import 'package:prayer_times/core/static/constants.dart';
import 'package:prayer_times/core/static/svg_path.dart';
import 'package:prayer_times/core/utility/utility.dart';
import 'package:prayer_times/domain/entities/social_link_entity.dart';
import 'package:prayer_times/presentation/contact_us/presenter/contact_us_ui_state.dart';

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
      SocialLinkEntity(
        title: 'Official Page',
        icon: SvgPath.icFacebook,
        onLinkClick: () => launchFacebookPage(),
      ),
      SocialLinkEntity(
        title: 'User Group',
        icon: SvgPath.icUserProfile,
        onLinkClick: () => launchFacebookGroup(),
      ),
      SocialLinkEntity(
        title: 'Twitter (X)',
        icon: SvgPath.icTwitter,
        onLinkClick: () => launchTwitter(),
      ),
      SocialLinkEntity(
        title: 'Youtube',
        icon: SvgPath.icCategoryFill,
        onLinkClick: () => launchYoutube(),
      ),
      SocialLinkEntity(
        title: 'Linkedin',
        icon: SvgPath.icLinkedin,
        onLinkClick: () => launchLinkedInProfile(),
      ),
      SocialLinkEntity(
        title: 'Website',
        icon: SvgPath.icGlobalSearch,
        onLinkClick: () => openUrl(url: websiteUrl),
      ),
    ];

    uiState.value = currentUiState.copyWith(socialLinks: links);
  }

  // Future<void> onSocialLinkTap(String url) async {
  //   await openUrl(url: url, context: currentUiState.context!);
  // }

  @override
  Future<void> addUserMessage(String message) async {
    uiState.value = currentUiState.copyWith(userMessage: message);
    showMessage(
      message: currentUiState.userMessage,
    );
  }

  @override
  Future<void> toggleLoading({required bool loading}) async {
    uiState.value = currentUiState.copyWith(isLoading: loading);
  }
}
