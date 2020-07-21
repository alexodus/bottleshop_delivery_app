import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;

  PushNotificationService({FirebaseMessaging fcm}) : _fcm = fcm ?? FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (message) async {
        print('onMessage: $message');
      },
      onLaunch: (message) async {
        print('onLaunch: $message');
      },
      onResume: (message) async {
        print('onResume: $message');
      },
    );
  }
}
