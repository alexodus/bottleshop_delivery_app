import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class DebugLogPrinter extends LogPrinter {
  final String className;

  DebugLogPrinter(this.className);
  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.levelColors[event.level];
    var emoji = PrettyPrinter.levelEmojis[event.level];
    return [color('$emoji $className - ${event.message}')];
  }
}

class AnalyticsService implements Analytics {
  final Crashlytics crashlytics;
  final FirebaseAnalytics analytics;

  AnalyticsService({@required this.crashlytics, @required this.analytics})
      : assert(crashlytics != null),
        assert(analytics != null);

  factory AnalyticsService.fromFirebase() {
    return AnalyticsService(
        analytics: FirebaseAnalytics(), crashlytics: Crashlytics.instance);
  }

  Function get recordError => crashlytics.recordError;
  Function get recordFlutterError => crashlytics.recordFlutterError;

  @override
  Future<void> logAppOpen() async {
    await analytics.logAppOpen();
  }

  @override
  Future<void> logLogin(String loginMethod) async {
    await analytics.logLogin(loginMethod: loginMethod);
  }

  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: analytics);
  }

  @override
  void logError(String msg) {
    crashlytics.log(msg);
  }

  @override
  Future<void> logAddToCart() {
    // TODO: implement logAddToCart
    throw UnimplementedError();
  }

  @override
  Future<void> logAddToWishlist() {
    // TODO: implement logAddToWishlist
    throw UnimplementedError();
  }

  @override
  Future<void> logBeginCheckout() {
    // TODO: implement logBeginCheckout
    throw UnimplementedError();
  }

  @override
  Future<void> logEcommercePurchase() {
    // TODO: implement logEcommercePurchase
    throw UnimplementedError();
  }

  @override
  Future<void> logRemoveFromCart() {
    // TODO: implement logRemoveFromCart
    throw UnimplementedError();
  }

  @override
  Future<void> logSearch() {
    // TODO: implement logSearch
    throw UnimplementedError();
  }

  @override
  Future<void> logSignUp(String method) async {
    await analytics.logSignUp(signUpMethod: method);
  }

  @override
  Future<void> logTutorialBegin() async {
    await analytics.logTutorialBegin();
  }

  @override
  Future<void> logTutorialComplete() async {
    await analytics.logTutorialComplete();
  }

  @override
  Future<void> logViewItem() {
    // TODO: implement logViewItem
    throw UnimplementedError();
  }

  @override
  Future<void> logViewItemList() {
    // TODO: implement logViewItemList
    throw UnimplementedError();
  }

  @override
  Future<void> logViewSearchResults() {
    // TODO: implement logViewSearchResults
    throw UnimplementedError();
  }

  @override
  Future<void> setCurrentScreen(String screenName) async {
    await analytics.setCurrentScreen(screenName: screenName);
  }
}
