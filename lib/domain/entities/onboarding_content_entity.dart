import 'package:prayer_times/core/base/base_entity.dart';

class OnboardingContentEntity extends BaseEntity {
  const OnboardingContentEntity({
    required this.title,
    required this.description,
    required this.image,
    required this.index,
  });

  final String title;
  final String description;
  final String image;
  final int index;

  @override
  List<Object?> get props => [
        title,
        description,
        image,
        index,
      ];
}
