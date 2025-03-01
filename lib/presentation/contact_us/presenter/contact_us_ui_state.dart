import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/domain/entities/social_link_entity.dart';

class ContactUsUiState extends BaseUiState {
  final List<SocialLinkEntity> socialLinks;

  const ContactUsUiState({
    required super.isLoading,
    required super.userMessage,
    required this.socialLinks,
  });

  factory ContactUsUiState.empty() {
    return const ContactUsUiState(
      isLoading: false,
      userMessage: '',
      socialLinks: [],
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        socialLinks,
      ];

  ContactUsUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<SocialLinkEntity>? socialLinks,
  }) {
    return ContactUsUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      socialLinks: socialLinks ?? this.socialLinks,
    );
  }
}
