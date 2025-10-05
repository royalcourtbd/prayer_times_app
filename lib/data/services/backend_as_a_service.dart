import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salat_times/core/utility/logger_utility.dart';
import 'package:salat_times/core/utility/trial_utility.dart';
import 'package:salat_times/data/models/device_info_model.dart';
import 'package:salat_times/data/models/payment_model.dart';
import 'package:salat_times/domain/entities/device_info_entity.dart';
import 'package:synchronized/synchronized.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

/// By separating the Firebase code into its own class, we can make it easier to
/// replace Firebase with another backend-as-a-service provider in the future.
///
/// This is because the rest of the app only depends on the public interface of
/// the `BackendAsAService` class, and not on the specific implementation details
/// of Firebase.
/// Therefore, if we decide to switch to a different backend-as-a-service
/// provider, we can simply create a new class that implements the same public
/// interface and use that instead.
///
/// This can help improve the flexibility of the app and make it easier to adapt
/// to changing business requirements or market conditions.
/// It also reduces the risk of vendor lock-in, since we are not tightly
/// coupling our app to a specific backend-as-a-service provider.
///
/// Overall, separating Firebase code into its own class can help make our app
/// more future-proof and adaptable to changing needs.
class BackendAsAService {
  BackendAsAService() {
    _initAnalytics();
  }
  late final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  late final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final Lock _listenToDeviceTokenLock = Lock();
  String? _inMemoryDeviceToken;

  static const String noticeCollection = 'notice';
  static const String noticeDoc = 'notice-bn';
  static const String appUpdateDoc = 'app-update';
  static const String deviceTokensCollection = 'device_tokens';
  static const String paymentsCollection = 'payments';
  static const String paymentType = 'payment_type';
  static const String isActive = 'is_active';

  void _initAnalytics() {
    catchVoid(() {
      _analytics
          .setAnalyticsCollectionEnabled(true)
          .then((_) => _analytics.logAppOpen());
    });
  }

  Future<void> logEvent(
      {required String name, Map<String, Object>? parameters}) async {
    await catchFutureOrVoid(() async {
      await _analytics.logEvent(name: name, parameters: parameters);
    });
  }

  Future<void> getRemoteNotice({
    required void Function(Map<String, Object?>) onNotification,
  }) async {
    await catchFutureOrVoid(() async {
      _fireStore
          .collection(noticeCollection)
          .doc(noticeDoc)
          .snapshots()
          .listen((docSnapshot) {
        onNotification(docSnapshot.data() ?? {});
      });
    });
  }

  Future<Map<String, dynamic>> getAppUpdateInfo() async {
    Map<String, dynamic>? appUpdateInfo = {};
    appUpdateInfo = await catchAndReturnFuture(() async {
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _fireStore.collection(noticeCollection).doc(appUpdateDoc).get();
      return docSnapshot.data();
    });
    return appUpdateInfo ?? {};
  }

  Future<void> listenToDeviceToken({
    required void Function(String) onTokenFound,
  }) async =>
      catchFutureOrVoid(
          () async => await _listenToDeviceToken(onTokenFound: onTokenFound));

  Future<void> _listenToDeviceToken({
    required void Function(String) onTokenFound,
  }) async {
    // prevents this function to be called multiple times in short period
    await _listenToDeviceTokenLock.synchronized(() async {
      catchFutureOrVoid(() async {
        _inMemoryDeviceToken ??= await _messaging.getToken();
        logDebug("Device token refreshed -> $_inMemoryDeviceToken");
        if (_inMemoryDeviceToken != null) onTokenFound(_inMemoryDeviceToken!);

        _messaging.onTokenRefresh.listen((String? token) {
          logDebug("Device token refreshed -> $token");
          if (token != null) onTokenFound(token);
        });
      });
    });
  }

  Stream<List<DeviceInfoEntity>> getAllRegisteredDevices() {
    return _fireStore.collection(deviceTokensCollection).snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) {
              return catchAndReturn<DeviceInfoEntity>(() {
                return DeviceInfoModel.fromJson(doc.data());
              });
            })
            .where((entity) => entity != null)
            .cast<DeviceInfoEntity>()
            .toList();
      },
    ).handleError((error, stackTrace) {
      logError(
          "Error in getAllRegisteredDevices stream: $error stackTrace: $stackTrace");
      return <DeviceInfoEntity>[];
    });
  }

  Future<void> registerDevice({int maxRetry = 3}) async {
    await catchFutureOrVoid(() async {
      final String? token = await _messaging.getToken();
      if (token == null) {
        logDebug('Token not found');
        return;
      }

      DeviceInfoModel deviceInfo = await _getDeviceInfo();
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();

      final String deviceId = deviceInfo.deviceId;
      if (deviceId.isEmpty) {
        logError('Device ID is empty');
        return;
      }

      try {
        final bool isFirstInstall = await catchAndReturnFuture(() async {
              final DocumentSnapshot<Map<String, dynamic>> doc =
                  await _fireStore
                      .collection(deviceTokensCollection)
                      .doc(deviceId)
                      .get();
              return !doc.exists;
            }) ??
            true;

        deviceInfo = deviceInfo.copyWith(
          token: token,
          appVersion: packageInfo.version,
          isOnline: true,
        );

        // এটি সার্ভার টাইমস্ট্যাম্প ব্যবহার করে
        final Map<String, dynamic> updateData =
            deviceInfo.toJsonWithServerTimestamp(
          isFirstInstall: isFirstInstall,
        );

        if (isFirstInstall) {
          await _fireStore.collection(deviceTokensCollection).doc(deviceId).set(
                updateData,
                SetOptions(merge: true),
              );
          logDebug('New device token registered: $token');
        } else {
          // আপডেট ব্যবহার করার সময় installedAt ফিল্ড ডিলিট করার দরকার নেই
          // toJsonWithServerTimestamp মেথড স্বয়ংক্রিয়ভাবে হ্যান্ডেল করবে
          await _fireStore
              .collection(deviceTokensCollection)
              .doc(deviceId)
              .update(updateData);
          logDebug('Device token updated: $token');
        }
      } catch (e) {
        logError('Error registering device: $e');

        // ব্যর্থ হলে পুনরায় চেষ্টা করুন, কিন্তু maxRetry সীমা অতিক্রম না করে
        if (maxRetry > 0) {
          logDebug(
              'Retrying device registration. Attempts left: ${maxRetry - 1}');
          await Future.delayed(
              Duration(seconds: 2)); // পুনঃচেষ্টার আগে অপেক্ষা করুন
          await registerDevice(maxRetry: maxRetry - 1);
        }
      }
    });
  }

  Future<DeviceInfoModel> _getDeviceInfo() async {
    return await catchAndReturnFuture<DeviceInfoModel>(() async {
          final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          String deviceId = '';
          String platform = '';
          String model = '';
          String osVersion = '';

          if (Platform.isAndroid) {
            final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
            platform = 'android';
            model = '${androidInfo.brand} ${androidInfo.model}';
            osVersion = androidInfo.version.release;
            deviceId = androidInfo.id;
          } else if (Platform.isIOS) {
            final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
            platform = 'ios';
            model = iosInfo.model;
            osVersion = iosInfo.systemVersion;
            deviceId = iosInfo.identifierForVendor ?? '';
          }

          return DeviceInfoModel(
            deviceId: deviceId,
            token: '', // এটি পরে আপডেট করা হবে
            platform: platform,
            model: model,
            osVersion: osVersion,
            appVersion: '',
            lastActiveAt: DateTime.now(),
          );
        }) ??
        DeviceInfoModel(
          deviceId: '',
          token: '',
          platform: '',
          model: '',
          osVersion: '',
          appVersion: '',
          lastActiveAt: DateTime.now(),
        );
  }

  Stream<List<BankPaymentModel>> getBankPaymentsStream() {
    return _fireStore
        .collection(paymentsCollection)
        .where(paymentType, isEqualTo: 'bank')
        .where(isActive, isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => catchAndReturn<BankPaymentModel>(() {
                return BankPaymentModel.fromFirestore(doc.data());
              }))
          .where((model) => model != null)
          .cast<BankPaymentModel>()
          .toList();
    }).handleError((error) {
      logError('Error in bank payments stream: $error');
      return <BankPaymentModel>[];
    });
  }

  Stream<List<MobilePaymentModel>> getMobilePaymentsStream() {
    return _fireStore
        .collection(paymentsCollection)
        .where(paymentType, isEqualTo: 'mobile')
        .where(isActive, isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => catchAndReturn<MobilePaymentModel>(() {
                return MobilePaymentModel.fromFirestore(doc.data());
              }))
          .where((model) => model != null)
          .cast<MobilePaymentModel>()
          .toList();
    }).handleError((error) {
      logError('Error in mobile payments stream: $error');
      return <MobilePaymentModel>[];
    });
  }
}
