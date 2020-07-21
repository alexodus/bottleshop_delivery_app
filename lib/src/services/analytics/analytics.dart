import 'package:bottleshopdeliveryapp/src/services/analytics/analytics_service.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:logger/logger.dart';

abstract class Analytics {
  Future<void> logAppOpen();
  Future<void> logLogin(String loginMethod);
  Future<void> setCurrentScreen(String screenName);
  Future<void> logAddToCart();
  Future<void> logAddToWishlist();
  Future<void> logBeginCheckout();
  Future<void> logEcommercePurchase();
  Future<void> logRemoveFromCart();
  Future<void> logSearch();
  Future<void> logSignUp(String method);
  Future<void> logTutorialBegin();
  Future<void> logTutorialComplete();
  Future<void> logViewItem();

  FirebaseAnalyticsObserver get analyticsObserver;
  static Logger getLogger(String className) {
    return Logger(printer: DebugLogPrinter(className));
  }

  static void setLogLevel(Level level) {
    Logger.level = level;
  }
}
