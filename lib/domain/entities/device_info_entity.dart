import 'package:prayer_times/core/base/base_entity.dart';

class DeviceInfoEntity extends BaseEntity {
  final String deviceId;
  final String token;
  final String platform;
  final String model;
  final String osVersion;
  final String appVersion;
  final DateTime? installedAt;
  final DateTime lastActiveAt;
  final bool isOnline;
  final DateTime? onlineUpdatedAt;

  const DeviceInfoEntity({
    required this.deviceId,
    required this.token,
    required this.platform,
    required this.model,
    required this.osVersion,
    required this.appVersion,
    this.installedAt,
    required this.lastActiveAt,
    this.isOnline = false,
    this.onlineUpdatedAt,
  });

  @override
  List<Object?> get props => [
        deviceId,
        token,
        platform,
        model,
        osVersion,
        appVersion,
        installedAt,
        lastActiveAt,
        isOnline,
        onlineUpdatedAt,
      ];
}
