import 'package:flutter/material.dart';
import 'package:qibla_and_prayer_times/core/base/base_ui_state.dart';
import 'package:qibla_and_prayer_times/domain/entities/social_link_entity.dart';

class ContactUsUiState extends BaseUiState {
  final List<SocialLinkEntity> socialLinks;
  final BuildContext? context;

  const ContactUsUiState({
    required super.isLoading,
    required super.userMessage,
    required this.socialLinks,
    this.context,
  });

  factory ContactUsUiState.empty() {
    return const ContactUsUiState(
      isLoading: false,
      userMessage: '',
      socialLinks: [],
      context: null,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        userMessage,
        socialLinks,
        context,
      ];

  ContactUsUiState copyWith({
    bool? isLoading,
    String? userMessage,
    List<SocialLinkEntity>? socialLinks,
    BuildContext? context,
  }) {
    return ContactUsUiState(
      isLoading: isLoading ?? this.isLoading,
      userMessage: userMessage ?? this.userMessage,
      socialLinks: socialLinks ?? this.socialLinks,
      context: context ?? this.context,
    );
  }
}
