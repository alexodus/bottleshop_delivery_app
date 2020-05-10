import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

abstract class Analytics {
  Logger getLogger(String className);
  Future<void> logAppOpen();
  Future<void> logLogin();
  Future<void> logError();
}

abstract class BaseAnalyticsEngine {
  @protected
  FirebaseAnalytics firebaseAnalyticsInstance;

  @protected
  Crashlytics crashlyticsInstance;

  void setLogLevel({Level level = Level.verbose});
}
