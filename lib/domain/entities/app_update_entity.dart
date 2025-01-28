import 'package:qibla_and_prayer_times/core/base/base_entity.dart';

class AppUpdateEntity extends BaseEntity {
  final String changeLog;
  final bool forceUpdate;
  final String latestVersion;
  final String title;
  final bool askToUpdate;

  const AppUpdateEntity({
    required this.changeLog,
    required this.forceUpdate,
    required this.latestVersion,
    required this.title,
    required this.askToUpdate,
  });

  @override
  List<Object?> get props => [
        changeLog,
        forceUpdate,
        latestVersion,
        title,
        askToUpdate,
      ];
}
