// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD5xT3mTmLrs1fmZYH1_eIHYf2ui5G8aoo',
    appId: '1:989584046245:web:3bdafd9b15af094522f54c',
    messagingSenderId: '989584046245',
    projectId: 'qibla-and-prayer-times-9d86a',
    authDomain: 'qibla-and-prayer-times-9d86a.firebaseapp.com',
    storageBucket: 'qibla-and-prayer-times-9d86a.firebasestorage.app',
    measurementId: 'G-VDGMWSPXHB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVyURZZ-iCu4Ioi9fAgpy9ZXOKwOYM5Xc',
    appId: '1:989584046245:android:93c352267d10588022f54c',
    messagingSenderId: '989584046245',
    projectId: 'qibla-and-prayer-times-9d86a',
    storageBucket: 'qibla-and-prayer-times-9d86a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAED3uQRhwqlR7UCntHunOja4b43Jn_-4U',
    appId: '1:989584046245:ios:1db2ef92866a008422f54c',
    messagingSenderId: '989584046245',
    projectId: 'qibla-and-prayer-times-9d86a',
    storageBucket: 'qibla-and-prayer-times-9d86a.firebasestorage.app',
    iosBundleId: 'com.royalcourtbd.qiblaAndPrayerTimes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAED3uQRhwqlR7UCntHunOja4b43Jn_-4U',
    appId: '1:989584046245:ios:1db2ef92866a008422f54c',
    messagingSenderId: '989584046245',
    projectId: 'qibla-and-prayer-times-9d86a',
    storageBucket: 'qibla-and-prayer-times-9d86a.firebasestorage.app',
    iosBundleId: 'com.royalcourtbd.qiblaAndPrayerTimes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD5xT3mTmLrs1fmZYH1_eIHYf2ui5G8aoo',
    appId: '1:989584046245:web:cf27973e4ebde4b422f54c',
    messagingSenderId: '989584046245',
    projectId: 'qibla-and-prayer-times-9d86a',
    authDomain: 'qibla-and-prayer-times-9d86a.firebaseapp.com',
    storageBucket: 'qibla-and-prayer-times-9d86a.firebasestorage.app',
    measurementId: 'G-XD68KRBNVN',
  );
}
