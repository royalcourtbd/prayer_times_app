import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qibla_and_prayer_times/domain/entities/device_info_entity.dart';

class DeviceInfoModel extends DeviceInfoEntity {
  const DeviceInfoModel({
    required super.deviceId,
    required super.token,
    required super.platform,
    required super.model,
    required super.osVersion,
    required super.appVersion,
    super.installedAt,
    required super.lastActiveAt,
    super.isOnline = false,
    super.onlineUpdatedAt,
  });

  factory DeviceInfoModel.fromJson(Map<String, dynamic> json) {
    // Firestore Timestamp থেকে DateTime এ কনভার্ট করার ফাংশন
    DateTime? convertTimestampToDateTime(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) {
        return value.toDate();
      } else if (value is String) {
        return DateTime.tryParse(value);
      }
      return null;
    }

    return DeviceInfoModel(
      deviceId: json['deviceId'] as String,
      token: json['token'] as String,
      platform: json['platform'] as String,
      model: json['model'] as String,
      osVersion: json['osVersion'] as String,
      appVersion: json['appVersion'] as String,
      installedAt: convertTimestampToDateTime(json['installedAt']),
      lastActiveAt:
          convertTimestampToDateTime(json['lastActiveAt']) ?? DateTime.now(),
      isOnline: json['isOnline'] as bool? ?? false,
      onlineUpdatedAt: convertTimestampToDateTime(json['onlineUpdatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'token': token,
      'platform': platform,
      'model': model,
      'osVersion': osVersion,
      'appVersion': appVersion,
      'installedAt': installedAt?.toIso8601String(),
      'lastActiveAt': lastActiveAt.toIso8601String(),
      'isOnline': isOnline,
      'onlineUpdatedAt': onlineUpdatedAt?.toIso8601String(),
    };
  }

  DeviceInfoModel copyWith({
    String? deviceId,
    String? token,
    String? platform,
    String? model,
    String? osVersion,
    String? appVersion,
    DateTime? installedAt,
    DateTime? lastActiveAt,
    bool? isOnline,
    DateTime? onlineUpdatedAt,
  }) {
    return DeviceInfoModel(
      deviceId: deviceId ?? this.deviceId,
      token: token ?? this.token,
      platform: platform ?? this.platform,
      model: model ?? this.model,
      osVersion: osVersion ?? this.osVersion,
      appVersion: appVersion ?? this.appVersion,
      installedAt: installedAt ?? this.installedAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      isOnline: isOnline ?? this.isOnline,
      onlineUpdatedAt: onlineUpdatedAt ?? this.onlineUpdatedAt,
    );
  }
}
