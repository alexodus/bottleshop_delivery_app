import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final logger = Analytics.getLogger('MyApp');
  final FirebaseMessaging _fcm;
  bool _isInitialized = false;

  PushNotificationService({FirebaseMessaging fcm}) : _fcm = fcm ?? FirebaseMessaging();

  Future<void> initialise() async {
    if (!_isInitialized) {
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );
      _fcm.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));
      _fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });
      String token = await _fcm.getToken();
      print("FCM Token: $token");
      this._isInitialized = true;
    }
  }
}
