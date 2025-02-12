import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_app_screen.dart';
import 'package:qibla_and_prayer_times/core/config/prayer_time_theme_color.dart';
import 'package:qibla_and_prayer_times/core/external_libs/flutter_toast/toast_utility.dart';
import 'package:qibla_and_prayer_times/core/external_libs/throttle_service.dart';
import 'package:qibla_and_prayer_times/core/static/constants.dart';
import 'package:qibla_and_prayer_times/core/utility/logger_utility.dart';
import 'package:qibla_and_prayer_times/core/utility/number_utility.dart';
import 'package:qibla_and_prayer_times/core/utility/trial_utility.dart';
import 'package:responsive_sizer/responsive_sizer.dart' as rs;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

bool get isMobile => rs.Device.screenType == rs.ScreenType.mobile;
const String _fileName = "utility.dart";
String? _currentAppVersion;

ColorFilter buildColorFilterToChangeColor(Color? color) =>
    ColorFilter.mode(color ?? Colors.black, BlendMode.srcATop);

extension ContextExtensions on BuildContext {
  Future<T?> navigatorPush<T>(Widget page) async {
    try {
      if (!mounted) return null;
      final CupertinoPageRoute<T> route =
          CupertinoPageRoute<T>(builder: (context) => page);
      return Navigator.push<T>(this, route);
    } catch (e) {
      logError("Failed to navigate to ${e.runtimeType} -> $e");
      return null;
    }
  }

  Future<T?> navigatorPushReplacement<T>(Widget page) async {
    try {
      if (!mounted) return null;
      final CupertinoPageRoute<T> route =
          CupertinoPageRoute<T>(builder: (context) => page);
      return Navigator.pushReplacement(this, route);
    } catch (e) {
      logError("Failed to navigate to ${e.runtimeType} -> $e");
      return null;
    }
  }

  Future<T?> showBottomSheetLegacy<T>(Widget bottomSheet) async {
    return Get.bottomSheet<T>(
      bottomSheet,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(twentyPx),
          topRight: Radius.circular(twentyPx),
        ),
      ),
    );
  }

  Future<T?> showBottomSheet<T>(
      Widget bottomSheet, BuildContext context) async {
    if (!mounted) return null;
    final T? result = await showModalBottomSheet<T>(
      context: context,
      builder: (context) => bottomSheet,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(twentyPx),
          topRight: Radius.circular(twentyPx),
        ),
      ),
    );
    return result;
  }

  void navigatorPop<T>({T? result}) {
    if (!mounted) return;
    Navigator.pop(this, result);
  }
}

Future<void> showMessage({
  String? message,
}) async {
  if (message == null || message.isEmpty) return;

  ToastUtility.showCustomToast(
    message: message,
    yOffset: 100.0,
    duration: const Duration(milliseconds: 1000),
  );
}

/// Helper extension that allows to use a color like:
/// `context.color.primary`
extension ThemeContextExtension on BuildContext {
  PrayerTimeThemeColor get color {
    return Theme.of(this).extension<PrayerTimeThemeColor>()!;
  }
}

/// Helper extension that allows to use color with opacity like:
/// `context.color.primary.withOpacityInt(0.1)`
extension ColorOpacityExtension on Color {
  Color withOpacityInt(double opacity) {
    return withAlpha((opacity * 255).toInt());
  }
}

isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

/// Checks the internet connection asynchronously.
///
///
/// Example usage:
///
/// ```dart
/// bool isConnected = await checkInternetConnection();
/// if (isConnected) {
///   logDebug('Internet connection is available.');
/// } else {
///   logDebug('No internet connection.');
/// }
/// ```
///
/// Rationale:
///
/// The `checkInternetConnection` function provides a straightforward way to determine
/// the availability of an internet connection within your Flutter application. By performing
/// a lookup for a well-known URL, it checks if the device can successfully resolve the URL's
/// IP address, indicating an active internet connection.
///

Future<bool> checkInternetConnection() async {
  final bool? isConnected = await catchAndReturnFuture(() async {
    const String kLookUpUrl = 'www.google.com';
    final List<InternetAddress> result =
        await InternetAddress.lookup(kLookUpUrl);
    if (result.isEmpty) return false;
    if (result.first.rawAddress.isEmpty) return false;
    return true;
  });
  return isConnected ?? false;
}

Future<void> copyText({required String text}) async {
  await catchFutureOrVoid(() async {
    if (text.isEmpty) return;
    final ClipboardData clipboardData = ClipboardData(text: text);
    await Clipboard.setData(clipboardData);
  });
}

Future<void> shareText({required String text}) async {
  await catchFutureOrVoid(() async => Share.share(text));
}

// const String reportEmailAddress = 'report.irdfoundation@gmail.com';
// const String donationUrl = 'https://irdfoundation.com/sadaqa-jaria.html';
// const String messengerUrl = "https://m.me/ihadis.official";
// const String twitterUrl = "https://twitter.com/irdofficial";
// const String facebookGroupUrl = "https://www.facebook.com/groups/irdofficial";
// const String facebookPageUrl = "https://www.facebook.com/ihadis.official";

// Future<String> getEmailBody() async {
//   final String reportInfo = await getDeviceInfo();
//   final String currentVersion = await currentAppVersion;
//   return '''
// যে সমস্যাটি রিপোর্ট করছেন:

// App Version: $currentVersion
// ডিভাইস ইনফরমেশন:
// ${reportInfo.replaceAll(" ", ' ')}
// ''';
// }

/// Sends an email asynchronously with the specified subject, body, and email address.
///
/// Example usage:
///
/// ```dart
/// await sendEmail(subject: 'Feedback', body: 'Hello, I have some feedback...');
/// ```
///
/// Rationale:
///
/// - provides a simple way to send emails asynchronously from within
/// your Flutter application.
/// - encapsulates the process of composing an email with the
/// specified subject, body, and recipient address,
/// abstracting away the complexities of
/// integrating with the device's default email client.
// Future<void> sendEmail({
//   String subject = "",
//   String body = "",
//   String email = reportEmailAddress,
// }) async {
//   String emailBody = body;
//   if (emailBody.isEmpty) emailBody = await getEmailBody();

//   final Map<String, String> mailContent = {
//     'subject': subject,
//     'body': emailBody
//   };
//   final Uri uri = Uri(
//     scheme: 'mailto',
//     path: email,
//     queryParameters: mailContent,
//   );
//   final String urlString = uri.toString();
//   await openUrl(url: urlString);
// }

// /// Launches the Facebook page of the app or opens a fallback URL in a browser
// /// if the Facebook app is not installed on the user's device.
// ///
// /// First checks if the user's device is an iOS device or not and then
// /// generates a protocol URL to launch the Facebook page.
// /// If the URL can be launched, it is launched, else it opens the fallback URL.
// ///
// /// This function makes use of openUrl() function to launch the URL, and the
// /// fallback URL is set to the official Facebook page URL of the app.
// ///
// /// If the URL can be launched, it opens the Facebook page in the Facebook app,
// /// otherwise, it opens the fallback URL in a browser.
Future<void> launchFacebookPage() async {
  final String fbProtocolUrl = Platform.isIOS
      ? 'fb://profile/153267368647572'
      : 'fb://page/153267368647572';
  await openUrl(
    url: fbProtocolUrl,
    fallbackUrl: facebookPageUrl,
  );
}

Future<void> launchFacebookGroup() async {
  const String fbProtocolUrl = 'fb://group/irdofficial';
  await openUrl(
    url: fbProtocolUrl,
    fallbackUrl: facebookGroupUrl,
  );
}

Future<void> launchYoutube() async {
  const String channelId = 'UCnVaqAxLkEz9uCqkvJlPK8A';
  final String youtubeProtocolUrl = Platform.isIOS
      ? 'youtube://channel/$channelId'
      : 'https://www.youtube.com/channel/$channelId';
  const String fallbackUrl = 'https://www.youtube.com/channel/$channelId';
  await openUrl(
    url: youtubeProtocolUrl,
    fallbackUrl: fallbackUrl,
  );
}

Future<void> launchTwitter() async {
  await launchUrl(Uri.parse(twitterUrl));
}

Future<void> launchLinkedInProfile() async {
  const String userId = "md-abu-sayed-938334257";
  const String linkedInProtocolUrl = 'linkedin://in/$userId';
  const String fallbackUrl = 'https://www.linkedin.com/in/$userId/';

  await openUrl(
    url: linkedInProtocolUrl,
    fallbackUrl: fallbackUrl,
  );
}

Future<void> launchMessenger() async {
  const String facebookId = "153267368647572";

  final String fbProtocolUrl = Platform.isAndroid
      ? 'fb-messenger://user/$facebookId'
      : 'https://m.me/$facebookId';

  await openUrl(
    url: fbProtocolUrl,
    fallbackUrl: facebookPageUrl,
  );
}

// /// Returns the file path for the given [fileName] in the specified [directoryPath].
// ///
// /// If the file does not exist, it returns an empty string.
// Future<bool> fileExists(
//     {required String directoryPath, required String fileName}) async {
//   final String filePath = '$directoryPath/$fileName';
//   final bool isFileExists = await File(filePath).exists();
//   return isFileExists;
// }

// /// get application directory path
Future<String> getApplicationDirectoryPath() async {
  final Directory directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

// Future<String> getDatabaseFilePath(String fileName) async {
//   final directoryPath = await getApplicationDirectoryPath();
//   return join(directoryPath, fileName);
// }

// /// this function will check the fileName
// /// if fileName mached with the file then it will return true else false
// bool isNonDefaultTafseer(String fileName) {
//   return ["bn_fmazid", "bn_kathir", "bn_tafsir_kathir_mujibor"]
//       .contains(fileName);
// }

// /// Opens a URL asynchronously with optional fallback URL.
// ///
// /// Example usage:
// ///
// /// ```dart
// /// await openUrl(url: 'https://facebook.com/irdfoundation');
// /// ```
// ///
// /// Rationale:
// ///
// /// - provides a convenient way to open a URL asynchronously with an
// /// optional fallback URL.
// /// - utilizes the `Throttle` class to throttle multiple invocations
// /// within a specified time interval, ensuring that the function is not called too frequently.
// ///
Future<void> openUrl({
  required String? url,
  String fallbackUrl = "",
}) async {
  Throttle.throttle("openUrlThrottle", 1.inSeconds, () async {
    await catchFutureOrVoid(() async {
      if (url == null) return;
      if (url.trim().isEmpty) return;

      final Uri? uri = Uri.tryParse(url);
      final Uri? fallbackUri = Uri.tryParse(fallbackUrl);

      final bool validFallbackUri = fallbackUri != null;
      final bool validUri = uri != null;

      const String errorMessage = "Failed to open the URL";

      try {
        final bool canLaunch =
            validUri && (Platform.isAndroid || await canLaunchUrl(uri));

        if (canLaunch) {
          bool isLaunched =
              await launchUrl(uri, mode: LaunchMode.externalApplication);
          if (isLaunched) return;

          isLaunched = await launchUrl(uri);
          if (isLaunched) return;
        }

        if (!validUri) {
          await showMessage(
            message: errorMessage,
          );
          return;
        }

        validFallbackUri
            ? await launchUrl(fallbackUri, mode: LaunchMode.externalApplication)
            : await showMessage(
                message: errorMessage,
              );
      } catch (e) {
        logErrorStatic(e, _fileName);
        validFallbackUri
            ? await launchUrl(fallbackUri)
            : await showMessage(
                message: errorMessage,
              );
      }
    });
  });
}

Future<String> get currentAppVersion async {
  if (_currentAppVersion == null) {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _currentAppVersion = packageInfo.version;
  }
  log('currentAppVersion: $_currentAppVersion');
  return _currentAppVersion!;
}

String get suitableAppStoreUrl =>
    Platform.isAndroid ? playStoreUrl : appStoreUrl;

// String get suitableAppStoreUrl =>
//     Platform.isAndroid ? playStoreUrl : appStoreUrl;

void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
// Future<void> disposeKeyboard(
//     BuildContext context, TextEditingController editingController) async {
//   editingController.clear();
//   KeyboardService.dismiss(context: context);
// }

// Null Function(Object _)? doNothing(_) => null;

/// Retrieves the device information asynchronously.
///
/// Example usage:
///
/// ```dart
/// String deviceInfo = await getDeviceInfo();
/// print(deviceInfo);
/// ```
///
/// Rationale:
///
/// - The `getDeviceInfo` function provides a convenient way to retrieve device information
/// asynchronously.
/// - Utilizes the `catchAndReturnFuture` method to handle any errors that
/// might occur during the execution of the asynchronous code.
// Future<String> getDeviceInfo() async {
//   final String? deviceInfo = await catchAndReturnFuture(() async {
//     final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     String deviceModel = "";

//     if (Platform.isAndroid) {
//       final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       deviceModel = androidInfo.model;
//     }

//     if (Platform.isIOS) {
//       final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       deviceModel = "${iosInfo.utsname.machine}-${iosInfo.model}";
//     }

//     return "OS: ${Platform.operatingSystem}\n"
//         "OS Version: ${Platform.operatingSystemVersion}\n"
//         "Device Model: $deviceModel\n";
//   });

//   return deviceInfo ?? "";
// }

// extension IntDateExtension on int? {
//   DateTime get fromTimestampToDateTime {
//     if (this == null) return DateTime.now();
//     final DateTime date = DateTime.fromMillisecondsSinceEpoch(this!);
//     return date;
//   }
// }

// extension DateTimeExtension on DateTime {
//   int get toTimestamp => millisecondsSinceEpoch;
// }

String getFormattedCurrentDate() {
  return DateFormat('MMM dd, yyyy - EEEE').format(DateTime.now());
}

String getFormattedTime(DateTime? time) {
  return time != null ? DateFormat('hh:mm:ss a').format(time) : '--:--:--';
}

String getFormattedTimeForWaqtView(DateTime? time) {
  return time != null ? DateFormat('hh:mm\na').format(time) : '--:--';
}

String getFormattedTimeForFasting(DateTime? time) {
  return time != null ? DateFormat('hh:mm a').format(time) : '--:--';
}

String getFormattedDate(DateTime? date, {String format = 'dd MMM yyyy'}) {
  if (date == null) return '';
  return DateFormat(format).format(date);
}

String getFormattedDuration(Duration? duration) {
  if (duration == null) return '--:--';
  return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

// Future<void> updateTime({
//   required BuildContext context,
//   required String timeType,
//   required SettingsPresenter settingsPresenter,
// }) async {
//   final ThemeData theme = context.theme;
//   final TimeOfDay? newTime = await showTimePicker(
//     context: context,
//     initialEntryMode: TimePickerEntryMode.dialOnly,
//     initialTime: (timeType == 'startTime')
//         ? settingsPresenter.currentUiState.startTime
//         : settingsPresenter.currentUiState.endTime,
//     builder: (BuildContext context, Widget? child) {
//       return MediaQuery(
//         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
//         child: Theme(
//           data: context.theme.copyWith(
//             timePickerTheme: TimePickerThemeData(
//               backgroundColor: theme.scaffoldBackgroundColor,
//               dialHandColor: theme.colorScheme.primary,
//               dialTextColor: WidgetStateColor.resolveWith((state) {
//                 if (state.contains(WidgetState.selected)) {
//                   return Colors.white;
//                 }
//                 return theme.textTheme.bodyMedium!.color!;
//               }),
//               dayPeriodColor: theme.colorScheme.primary,
//               hourMinuteColor: WidgetStateColor.resolveWith((state) {
//                 if (state.contains(WidgetState.selected)) {
//                   return theme.primaryColor;
//                 }
//                 return theme.cardColor;
//               }),
//               hourMinuteTextColor: WidgetStateColor.resolveWith((state) {
//                 if (state.contains(WidgetState.selected)) {
//                   return Colors.white;
//                 }
//                 return theme.textTheme.bodyMedium!.color!;
//               }),
//               dayPeriodTextColor: WidgetStateColor.resolveWith((state) {
//                 if (state.contains(WidgetState.selected)) {
//                   return Colors.white;
//                 }
//                 return theme.textTheme.bodyMedium!.color!;
//               }),
//               shape: RoundedRectangleBorder(
//                 borderRadius: radius10,
//               ),
//             ),
//           ),
//           child: child!,
//         ),
//       );
//     },
//   );

//   if (newTime != null) {
//     if (timeType == 'startTime') {
//       await settingsPresenter.updateSettings(startTime: newTime);
//     } else {
//       await settingsPresenter.updateSettings(endTime: newTime);
//     }
//   }
// }

ColorFilter buildColorFilter(Color? color) =>
    ColorFilter.mode(color ?? Colors.black, BlendMode.srcATop);
