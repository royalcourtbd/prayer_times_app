import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:qibla_and_prayer_times/core/utility/logger_utility.dart';
import 'package:qibla_and_prayer_times/core/utility/trial_utility.dart';
import 'package:synchronized/synchronized.dart';

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
}
