import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
  final Crashlytics _crashlytics;
  final FirebaseAnalytics _analytics;

  AnalyticsService({FirebaseAnalytics firebaseAnalytics, Crashlytics crashlytics})
      : _crashlytics = crashlytics ?? Crashlytics.instance,
        _analytics = firebaseAnalytics ?? FirebaseAnalytics();

  Function get recordError => _crashlytics.recordError;
  Function get recordFlutterError => _crashlytics.recordFlutterError;

  @override
  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  @override
  Future<void> logLogin(String loginMethod) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }

  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(analytics: _analytics);
  }

  @override
  void logError(String msg) {
    _crashlytics.log(msg);
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
    await _analytics.setCurrentScreen(screenName: screenName);
  }
}
