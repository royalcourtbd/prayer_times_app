import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:qibla_and_prayer_times/core/utility/logger_utility.dart';

class GetServerKey {
  static const _scopes = [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/firebase.messaging',
    'https://www.googleapis.com/auth/firebase.database',
  ];

  Future<String> getServerKeyToken() async {
    log('getServerKeyToken');

    try {
      final credentialsJson = dotenv.env['FIREBASE_CREDENTIALS'];
      if (credentialsJson == null) {
        throw Exception('FIREBASE_CREDENTIALS not found in .env file');
      }

      final credentialsMap = json.decode(credentialsJson);

      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(credentialsMap),
        _scopes,
      );

      final token = client.credentials.accessToken.data;
      logDebug(token);

      return token;
    } catch (e) {
      logError('Error getting server key token: $e');
      throw Exception('Error getting server key token: $e');
    }
  }
}
