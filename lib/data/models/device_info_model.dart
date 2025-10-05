import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salat_times/core/utility/logger_utility.dart';
import 'package:salat_times/domain/entities/device_info_entity.dart';

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
      deviceId: json['deviceId'] as String? ?? '',
      token: json['token'] as String? ?? '',
      platform: json['platform'] as String? ?? '',
      model: json['model'] as String? ?? '',
      osVersion: json['osVersion'] as String? ?? '',
      appVersion: json['appVersion'] as String? ?? '',
      installedAt: convertTimestampToDateTime(json['installedAt']),
      lastActiveAt:
          convertTimestampToDateTime(json['lastActiveAt']) ?? DateTime.now(),
      isOnline: json['isOnline'] as bool? ?? false,
      onlineUpdatedAt: convertTimestampToDateTime(json['onlineUpdatedAt']),
    );
  }

  /// সাধারণ সংরক্ষণ করা নিজস্থ ফিল্ড সহ JSON তৈরি করে
  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'token': token,
      'platform': platform,
      'model': model,
      'osVersion': osVersion,
      'appVersion': appVersion,
      'installedAt':
          installedAt != null ? Timestamp.fromDate(installedAt!) : null,
      'lastActiveAt': Timestamp.fromDate(lastActiveAt),
      'isOnline': isOnline,
      'onlineUpdatedAt':
          onlineUpdatedAt != null ? Timestamp.fromDate(onlineUpdatedAt!) : null,
    };
  }

  /// সার্ভার টাইমস্ট্যাম্প ব্যবহার করে JSON তৈরি করে
  /// নতুন রেজিস্ট্রেশন বা আপডেটের সময় ব্যবহার করুন
  Map<String, dynamic> toJsonWithServerTimestamp(
      {bool isFirstInstall = false}) {
    try {
      final Map<String, dynamic> data = {
        'deviceId': deviceId,
        'token': token,
        'platform': platform,
        'model': model,
        'osVersion': osVersion,
        'appVersion': appVersion,
        'lastActiveAt': FieldValue.serverTimestamp(),
        'isOnline': isOnline,
        'onlineUpdatedAt': FieldValue.serverTimestamp(),
      };

      // শুধুমাত্র নতুন ইনস্টল হলে installedAt যোগ করুন
      if (isFirstInstall) {
        data['installedAt'] = FieldValue.serverTimestamp();
      }

      return data;
    } catch (e) {
      // এরর লগ করুন এবং ফলব্যাক হিসেবে রেগুলার টাইমস্ট্যাম্প ব্যবহার করুন
      logError('Server timestamp creation failed: $e');
      final regularData = toJson();

      // ফলব্যাক মোডে লগ করুন
      logDebug('Falling back to regular timestamps due to error');
      return regularData;
    }
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
