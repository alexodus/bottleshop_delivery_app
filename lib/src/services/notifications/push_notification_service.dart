import 'dart:io';

import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final logger = Analytics.getLogger('MyApp');
  final FirebaseMessaging _fcm;
  static PushNotificationService _instance;
  bool isInitialized = false;

  PushNotificationService._internal({FirebaseMessaging fcm})
      : _fcm = fcm ?? FirebaseMessaging();

  factory PushNotificationService({FirebaseMessaging fcm}) {
    return _instance ?? PushNotificationService._internal(fcm: fcm);
  }

  Future<void> initialise() async {
    if (isInitialized) {
      logger.w('PushNotificationService already initialized');
      return;
    }
    _fcm.configure(
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
    if (Platform.isIOS) {
      var result = await _fcm.requestNotificationPermissions(
        const IosNotificationSettings(
          sound: true,
          badge: true,
          alert: true,
          provisional: true,
        ),
      );
      if (result) {
        await _fcm.setAutoInitEnabled(true);
      }
    } else {
      await _fcm.setAutoInitEnabled(true);
    }
  }

  Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;

  Future<String> getFcmToken() async {
    var token = await _fcm.getToken();
    print('FCM Token: $token');
    return token;
  }
}
