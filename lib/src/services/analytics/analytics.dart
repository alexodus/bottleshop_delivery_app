import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics_service.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:logger/logger.dart';

abstract class Analytics {
  Future<void> logAppOpen();
  Future<void> logLogin(String loginMethod);
  Future<void> logSignUp(String method);
  Future<void> setCurrentScreen(String screenName);
  Future<void> setUserId(String id);
  Future<void> logAddToCart(Product product, int quantity);
  Future<void> logAddToWishlist(Product product, int quantity);
  Future<void> logEcommercePurchase(Order order);
  Future<void> logSearch(String searchTerm);
  Future<void> logTutorialBegin();
  Future<void> logTutorialComplete();
  Future<void> logViewItem(Product product);

  FirebaseAnalyticsObserver get analyticsObserver;
  static Logger getLogger(String className) {
    return Logger(printer: DebugLogPrinter(className));
  }

  static void setLogLevel(Level level) {
    Logger.level = level;
  }
}
