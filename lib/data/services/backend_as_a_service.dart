import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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

  void _initAnalytics() {
    _analytics
        .setAnalyticsCollectionEnabled(true)
        .then((_) => _analytics.logEvent(name: 'app_open'));
  }

  Future<void> logEvent(
      {required String name, Map<String, Object>? parameters}) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  late final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  late final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> getRemoteNotice({
    required void Function(Map<String, Object?>) onNotification,
  }) async {
    _fireStore
        .collection('notice')
        .doc('notice-bn')
        .snapshots()
        .listen((docSnapshot) {
      //
    });
  }

  Stream<Map<String, dynamic>> getAppUpdateInfoStream() {
    return _fireStore
        .collection("notice")
        .doc("app-update")
        .snapshots()
        .map((snapshot) => snapshot.data() ?? {});
  }
}
