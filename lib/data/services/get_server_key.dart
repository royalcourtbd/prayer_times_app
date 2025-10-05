import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:salat_times/core/utility/logger_utility.dart';
import 'package:salat_times/core/utility/trial_utility.dart';
import 'package:salat_times/core/utility/utility.dart';

class GetServerKey {
  static const _scopes = [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/firebase.messaging',
    'https://www.googleapis.com/auth/firebase.database',
  ];

  Future<String> getServerKeyToken() async {
    bool isConnected = await checkInternetConnection();
    if (!isConnected) {
      logDebug('No internet connection');
      return '';
    }

    final token = await catchAndReturnFuture<String>(() async {
      final String? credentialsJson = dotenv.env['FIREBASE_CREDENTIALS'];
      if (credentialsJson == null) {
        throw Exception('FIREBASE_CREDENTIALS not found in .env file');
      }

      final dynamic credentialsMap = json.decode(credentialsJson);

      final AutoRefreshingAuthClient client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(credentialsMap),
        _scopes,
      );

      final String token = client.credentials.accessToken.data;
      logDebugStatic('Token: $token', 'GetServerKey');

      return token;
    });

    if (token == null) {
      throw Exception('Failed to get server key token');
    }

    return token;
  }
}
