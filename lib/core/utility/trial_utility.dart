import 'dart:async';

import 'package:prayer_times/core/static/constants.dart';

import 'logger_utility.dart';

// These functions provide error handling and logging capabilities that can be
// used throughout the app.
//
// The [catchFutureOrVoid] function takes a [FutureOr<void>] function and wraps
// it in a try-catch block.
// If an error occurs, it logs the error and its trace using the [logErrorStatic]
// function and continues execution.
// This makes it easier to handle and log errors in asynchronous code that
// returns void.
//
// The [catchAndReturn] function takes a function that returns a value and wraps
// it in a try-catch block.
// If an error occurs, it logs the error and its trace using the [logErrorStatic]
// function and returns null.
// This makes it easier to handle and log errors in synchronous code that
// returns a value.
//
// The [TrialUtility.catchVoid] extension function is similar to
// [catchFutureOrVoid], but can be called on any object.
// It takes a [FutureOr<void>] function and wraps it in a try-catch block.
// If an error occurs, it logs the error and its trace using the [logError]
// function and continues execution.
// This makes it easier to handle and log errors in asynchronous code that
// returns void and is called on any object.

Future<void> catchFutureOrVoid(FutureOr<void> Function() function) async {
  try {
    await function();
  } catch (error, trace) {
    logErrorStatic("error: $error trace: $trace", packageName);
  }
}

void catchVoid(void Function() function) {
  try {
    function();
  } catch (error, trace) {
    logErrorStatic("error: $error trace: $trace", packageName);
  }
}

T? catchAndReturn<T>(T Function() function) {
  try {
    return function();
  } catch (error, trace) {
    logErrorStatic("error: $error trace: $trace", packageName);
    return null;
  }
}

Future<T?> catchAndReturnFuture<T>(FutureOr<T> Function() function) async {
  try {
    return await function();
  } catch (error, trace) {
    logErrorStatic("error: $error trace: $trace", packageName);
    return null;
  }
}

extension TrialUtility on Object? {
  Future<void> catchVoid(FutureOr<void> Function() function) async {
    try {
      await function();
    } catch (error, trace) {
      logError("error: $error trace: $trace");
    }
  }

  Future<T?> catchAndReturnFuture<T>(FutureOr<T> Function() function) async {
    try {
      return await function();
    } catch (error, trace) {
      logError("error: $error trace: $trace");
      return null;
    }
  }

  T? catchAndReturn<T>(T Function() function) {
    try {
      return function();
    } catch (error, trace) {
      logError("error: $error trace: $trace");
      return null;
    }
  }
}
