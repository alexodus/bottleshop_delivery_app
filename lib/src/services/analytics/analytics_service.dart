import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
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
  final FirebaseAnalytics _analytics;

  AnalyticsService({FirebaseAnalytics firebaseAnalytics}) : _analytics = firebaseAnalytics ?? FirebaseAnalytics() {
    _analytics.setAnalyticsCollectionEnabled(true);
  }

  @override
  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  Future<void> setUserId(String id) async {}

  @override
  Future<void> logLogin(String loginMethod) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }

  FirebaseAnalyticsObserver get analyticsObserver {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  @override
  Future<void> logAddToCart(
      {@required String itemId,
      @required String itemName,
      @required String itemCategory,
      @required int quantity}) async {
    return _analytics.logAddToCart(itemId: itemId, itemName: itemName, itemCategory: itemCategory, quantity: quantity);
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
    await _analytics.logSignUp(signUpMethod: method);
  }

  @override
  Future<void> logTutorialBegin() async {
    await _analytics.logTutorialBegin();
  }

  @override
  Future<void> logTutorialComplete() async {
    await _analytics.logTutorialComplete();
  }

  @override
  Future<void> logViewItem() {
    // TODO: implement logViewItem
    throw UnimplementedError();
  }

  @override
  Future<void> setCurrentScreen(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
  }
}
