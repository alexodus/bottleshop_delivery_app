import 'dart:io';

import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final logger = Analytics.getLogger('MyApp');
  final FirebaseMessaging _fcm;

  PushNotificationService({FirebaseMessaging fcm}) : _fcm = fcm ?? FirebaseMessaging();

  Future<void> initialise() async {
    if (Platform.isIOS) {
      await _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    final token = await _fcm.getToken();
    logger.d('fcm registered: $token');

    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
    });
  }
}
