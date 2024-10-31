import 'dart:developer' as dev;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:talker_logger/talker_logger.dart';

final TalkerLogger _logger = TalkerLogger();
const bool showLog = kDebugMode;

void logWriterCallBack(String message, {bool isError = false}) {
  if (!showLog) return;
  if (isError) _logErrorSystem(message);
  if (!isError) _logInfoStatic(message);
}

void _logErrorSystem<T extends Object>(T? exception) {
  if (!showLog) return;
  final String logName = "SYSTEM ERROR - ${DateTime.now()}";
  final String message =
      "${Platform.isIOS ? "" : logName} \n${exception is Error ? "$exception\n ${exception.stackTrace}" : exception}";
  Platform.isIOS ? dev.log(message, name: logName) : _logger.critical(message);
}

void _logInfoStatic<T extends Object>(T? object) {
  if (!showLog) return;
  final String logName = "SYSTEM DEBUG - ${DateTime.now()}";
  final String message =
      "${Platform.isIOS ? "" : logName} \n   ${object is Error ? "$object\n ${object.stackTrace}" : object}";
  Platform.isIOS ? dev.log(message, name: logName) : _logger.info(message);
}

/// Logs the given [exception] with the provided [name] as an error message
/// if [showLog] is true.
///
/// Example usage:
///
/// ```dart
///
/// logErrorStatic(Exception('An error occurred.'), 'myFunction');
///
/// [myFunction] [ERROR] - 2023-04-08 14:30:00.000
/// Exception: An error occurred.
/// ```
///
void logErrorStatic<T extends Object>(
  T? exception,
  String name,
) {
  if (!showLog) return;

  final String logName = "$name ERROR - ${DateTime.now()}";
  final String message =
      "${Platform.isIOS ? "" : logName} \n   ${exception is Error ? "$exception\n ${exception.stackTrace}" : exception}";
  Platform.isIOS ? dev.log(message, name: logName) : _logger.error(message);
}

/// Logs the given [object] with the provided [name] as a debug message
/// if [showLog] is true.
///
/// Example usage:
///
/// ```dart
///
/// logDebugStatic('Debug message.', 'myFunction');
///
/// [myFunction] [DEBUG] - 2023-04-08 14:30:00.000
/// Debug message.
/// ```
///
void logDebugStatic<T extends Object>(
  T? object,
  String name,
) {
  if (!showLog) return;

  final String logName = "$name DEBUG - ${DateTime.now()}";
  final String message =
      "${Platform.isIOS ? "" : logName} \n   ${object is Error ? "$object\n ${object.stackTrace}" : object}";
  Platform.isIOS ? dev.log(message, name: logName) : _logger.info(message);
}

/// An extension on [Object] that adds logging functionality.
extension ObjectLogger on Object? {
  /// Logs an error message with the provided [exception].
  ///
  /// If [showLog] is false, nothing will be logged.
  ///
  /// Example usage:
  ///
  /// ```dart
  ///
  /// final error = Exception('Something went wrong');
  /// this.logError();
  ///
  /// [MyClass] [ERROR] - 2023-04-08 11:30:00
  /// Exception: Something went wrong
  /// #0 main (file:///path/to/main.dart:10:11)
  ///
  /// ```
  ///
  void logError(Object? exception) {
    // to avoid runtimeType.toString() in release mode
    // as this can hamper performance, we use showLog
    // to check if we are in debug mode or not
    if (!showLog) return;
    // we are logging only in debug mode, so the performance hit can be ignored
    // ignore: no_runtimeType_toString
    logErrorStatic(exception, runtimeType.toString());
  }

  /// Logs a debug message with the provided [object].
  ///
  /// If [showLog] is false, nothing will be logged.
  ///
  /// Example usage:
  ///
  /// ```dart
  ///
  /// this.logDebug('This is a debug message');
  ///
  /// [MyClass] [DEBUG] - 2023-04-08 11:30:00
  /// This is a debug message
  ///
  /// ```
  ///
  void logDebug(Object object) {
    // to avoid runtimeType.toString() in release mode
    // as this can hamper performance, we use showLog
    // to check if we are in debug mode or not
    if (!showLog) return;
    // we are logging only in debug mode, so the performance hit can be ignored
    // ignore: no_runtimeType_toString
    logDebugStatic(object, runtimeType.toString());
  }
}
