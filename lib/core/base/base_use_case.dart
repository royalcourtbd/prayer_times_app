import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:salat_times/core/utility/logger_utility.dart';
import 'package:salat_times/domain/service/error_message_handler.dart';

/// The BaseUseCase class serves as a base for all use cases in the application.
///
/// The purpose of this class is to provide a common structure for all use cases,
/// making it easier to implement and maintain. The class provides a method
/// mapResultToEither that can be used to map the result of a function to either
/// a success value or an error string, making error handling more consistent across
/// the application.
///
/// The BaseUseCase class also takes an instance of ErrorMessageHandler in its
/// constructor, which can be used to generate error messages in a consistent way.
abstract class BaseUseCase<T> {
  BaseUseCase(this._errorMessageHandler);

  final ErrorMessageHandler _errorMessageHandler;

  /// Used to map the result of a function to either a success value or an error
  /// string.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Future<Either<String, T>> result = mapResultToEither(() async {
  ///     T value = await fetchData();
  ///     return value;
  /// });
  ///
  /// ```
  ///
  /// The function passed to `mapResultToEither` should return either a success
  /// value of type `T` or an error object.
  ///
  /// In case of success, the function will return a `Right` value with the success value.
  ///
  /// In case of error, the function will log the error, generate an error
  /// message using `_errorMessageHandler`, and return a `Left` value with the
  /// error message.
  @protected
  Future<Either<String, T>> mapResultToEither(
    FutureOr<T> Function() function,
  ) async {
    try {
      final T result = await function();
      return right(result);
    } catch (error, stack) {
      logError(error);
      logError(stack);
      final String errorMessage =
          _errorMessageHandler.generateErrorMessage(error);
      return left(errorMessage);
    }
  }

  /// Retrieves the right value from the result of a given function.
  ///
  /// This function executes the provided [function] and maps its result to an `Either` object.
  /// It then retrieves the right value from the `Either` object and returns it.
  /// If the right value is not present, it returns the [defaultValue] instead.
  ///
  /// Use Case:
  /// This function is useful when you have a function that can return different types of values or errors.
  /// By using `Either`, you can handle both successful results and error cases in a unified way.
  /// The `getRight` function simplifies the process of extracting the successful result when working with `Either`.
  ///
  /// Rationale:
  /// The `getRight` function abstracts the process of handling different result types and provides a more intuitive
  /// way to retrieve the successful value. By using `Either`, you can explicitly represent success and failure cases,
  /// making your code more robust and easier to reason about.
  ///
  /// Example:
  /// ```dart
  /// Future<Either<Error, int>> fetchData() async {
  ///   // Simulating an asynchronous operation that can fail or return a value
  ///   final result = await someAsyncOperation();
  ///
  ///   if (result.hasError) {
  ///     return left(Error('Failed to fetch data'));
  ///   } else {
  ///     return right(result.data);
  ///   }
  /// }
  ///
  /// Future<void> processResult() async {
  ///   final int data = await getRight(() => fetchData(), defaultValue: 0);
  ///   // Use the retrieved data or fallback to the default value if it's not available
  ///   print('Data: $data');
  /// }
  /// ```
  ///
  /// In the above example, the `fetchData` function returns an `Either` object representing either an error or the fetched data.

  /// The `getRight` function is used to extract the successful data from the `fetchData` result.
  /// This provides a convenient way to handle the result and proceed with further processing.
  @protected
  Future<T> getRight(FutureOr<T> Function() function) async {
    final Either<String, T> result = await mapResultToEither(() => function());
    return result
        .getRight()
        .getOrElse(() => throw Exception('No successful result available'));
  }

  /// Executes the provided function `function` and discards the result.
  ///
  ///
  /// Example usage:
  ///
  /// ```dart
  /// await doVoid(() async {
  ///   // Perform some asynchronous operation
  /// });
  /// ```
  ///
  /// Note: This function is intended for cases where you want to execute an
  /// asynchronous operation but don't require the result or error handling
  /// externally. If you need to handle the result or errors, consider using
  /// `mapResultToEither` or `getRight` functions instead.
  @protected
  Future<void> doVoid(FutureOr<T> Function() function) async {
    await mapResultToEither(() => function());
  }
}
