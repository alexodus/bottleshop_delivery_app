import 'package:bottleshopdeliveryapp/src/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics_service.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:logger/logger.dart';

abstract class Analytics {
  Future<void> logAppOpen();

  Future<void> logLogin(String loginMethod);

  Future<void> logSignUp(String method);

  Future<void> setCurrentScreen(String screenName);

  Future<void> setUserId(String id);

  Future<void> logAddToCart(ProductModel product, int quantity);

  Future<void> logAddToWishlist(ProductModel product, int quantity);

  Future<void> logEcommercePurchase(OrderModel order);

  Future<void> logSearch(String searchTerm);

  Future<void> logTutorialBegin();

  Future<void> logTutorialComplete();

  Future<void> logViewItem(ProductModel product);

  FirebaseAnalyticsObserver get analyticsObserver;

  void setAnalyticsCollectionEnabled(bool enabled);

  static Logger getLogger(String className) {
    return Logger(printer: DebugLogPrinter(className));
  }

  static void setLogLevel(Level level) {
    Logger.level = level;
  }
}
