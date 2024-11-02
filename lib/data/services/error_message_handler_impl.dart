// lib/data/services/error_message_handler_impl.dart

import 'package:qibla_and_prayer_times/domain/service/error_message_handler.dart';

class ErrorMessageHandlerImpl implements ErrorMessageHandler {
  @override
  String generateErrorMessage(Object error) {
    if (error is FormatException) {
      return 'ডেটা ফরম্যাট সঠিক নয়';
    }

    return error.toString();
  }
}
