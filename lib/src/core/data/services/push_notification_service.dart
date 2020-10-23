import 'dart:io';

import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool initialized = false;
  Logger _logger;
  String token;

  PushNotificationService() {
    _logger = createLogger(this.runtimeType.toString());
  }

  FirebaseMessaging get firebaseMessaging => _firebaseMessaging;

  Future<String> init() async {
    if (!initialized) {
      if (Platform.isIOS) {
        await _requestPermission();
      }
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('onLaunch: $message');
        },
        onResume: (Map<String, dynamic> message) async {
          print('onResume: $message');
        },
      );
      token = await _firebaseMessaging.getToken();
      if (token != null) {
        initialized = true;
      }
      _logger.d('token: $token');
      return token;
    }
    return token;
  }

  Future<bool> _requestPermission() {
    return _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
      provisional: false,
    ));
  }

  Stream<String> get onTokenRefreshed => _firebaseMessaging.onTokenRefresh;
}
