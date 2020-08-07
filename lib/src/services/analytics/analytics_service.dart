import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
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

  AnalyticsService({FirebaseAnalytics firebaseAnalytics, bool enableAnalyticsCollection = true})
      : _analytics = firebaseAnalytics ?? FirebaseAnalytics() {
    _analytics.setAnalyticsCollectionEnabled(enableAnalyticsCollection);
  }

  @override
  FirebaseAnalyticsObserver get analyticsObserver => FirebaseAnalyticsObserver(analytics: _analytics);

  @override
  Future<void> logAddToCart(Product product, [int quantity = 1]) async {
    return _analytics.logAddToCart(
        itemId: product.documentID, itemName: product.name, itemCategory: product.category, quantity: quantity);
  }

  @override
  Future<void> logAddToWishlist(Product product, [int quantity = 1]) async {
    return _analytics.logAddToWishlist(
        itemId: product.documentID, itemName: product.name, itemCategory: product.category, quantity: quantity);
  }

  @override
  Future<void> logLogin(String loginMethod) async {
    return _analytics.logLogin(loginMethod: loginMethod);
  }

  @override
  Future<void> logAppOpen() async {
    return _analytics.logAppOpen();
  }

  @override
  Future<void> setCurrentScreen(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
  }

  @override
  Future<void> setUserId(String id) async {
    return _analytics.setUserId(id);
  }

  @override
  Future<void> logSignUp(String method) async {
    return _analytics.logSignUp(signUpMethod: method);
  }

  @override
  Future<void> logTutorialBegin() async {
    return _analytics.logTutorialBegin();
  }

  @override
  Future<void> logTutorialComplete() async {
    return _analytics.logTutorialComplete();
  }

  @override
  Future<void> logEcommercePurchase(Order order) async {
    return _analytics.logEcommercePurchase(transactionId: order.documentId, value: order.totalValue);
  }

  @override
  Future<void> logSearch(String searchTerm) async {
    return _analytics.logSearch(searchTerm: searchTerm);
  }

  @override
  Future<void> logViewItem(Product product) async {
    return _analytics.logViewItem(itemId: product.documentID, itemName: product.name, itemCategory: product.category);
  }
}
