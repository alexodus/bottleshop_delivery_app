import 'dart:async';

import 'package:bottleshopdeliveryapp/models/user.dart';
import 'package:bottleshopdeliveryapp/screens/wrapper.dart';
import 'package:bottleshopdeliveryapp/services/auth_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned(() {
    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      create: (_) => AuthService().user,
      catchError: (_, __) => null,
      child: MaterialApp(
        home: Wrapper(),
        navigatorObservers: <NavigatorObserver>[
          observer,
        ],
      ),
    );
  }
}
