class SocialLinkEntity {
  final String title;
  final String icon;
  final void Function() onLinkClick;

  const SocialLinkEntity({
    required this.title,
    required this.icon,
    required this.onLinkClick,
  });
}
