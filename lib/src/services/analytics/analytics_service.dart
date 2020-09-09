import 'package:bottleshopdeliveryapp/src/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/models/product_model.dart';
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

  AnalyticsService(
      {FirebaseAnalytics firebaseAnalytics,
      bool enableAnalyticsCollection = true})
      : _analytics = firebaseAnalytics ?? FirebaseAnalytics() {
    _analytics.setAnalyticsCollectionEnabled(enableAnalyticsCollection);
  }

  @override
  FirebaseAnalyticsObserver get analyticsObserver =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  @override
  Future<void> logAddToCart(ProductModel product, [int quantity = 1]) async {
    return _analytics.logAddToCart(
        itemId: product.uniqueId,
        itemName: product.name,
        itemCategory: product.allCategories[0].categoryDetails.name,
        quantity: quantity);
  }

  @override
  Future<void> logAddToWishlist(ProductModel product,
      [int quantity = 1]) async {
    return _analytics.logAddToWishlist(
        itemId: product.uniqueId,
        itemName: product.name,
        itemCategory: product.allCategories[0].categoryDetails.name,
        quantity: quantity);
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
  Future<void> logEcommercePurchase(OrderModel order) async {
    return _analytics.logEcommercePurchase(
        transactionId: order.id, value: order.totalPaid);
  }

  @override
  Future<void> logSearch(String searchTerm) async {
    return _analytics.logSearch(searchTerm: searchTerm);
  }

  @override
  Future<void> logViewItem(ProductModel product) async {
    return _analytics.logViewItem(
        itemId: product.uniqueId,
        itemName: product.name,
        itemCategory: product.allCategories.first.categoryDetails.name);
  }
}
