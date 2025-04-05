import 'package:prayer_times/domain/entities/app_update_entity.dart';

class AppUpdateModel extends AppUpdateEntity {
  const AppUpdateModel({
    required super.changeLog,
    required super.forceUpdate,
    required super.latestVersion,
    required super.title,
    required super.askToUpdate,
  });

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) {
    return AppUpdateModel(
      changeLog: json['change_log'] as String? ?? '',
      forceUpdate: json['force_update'] as bool? ?? false,
      latestVersion: json['latest_version'] as String? ?? '',
      title: json['title'] as String? ?? '',
      askToUpdate: json['ask_to_update'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'change_log': changeLog,
      'force_update': forceUpdate,
      'latest_version': latestVersion,
      'title': title,
      'ask_to_update': askToUpdate,
    };
  }
}
