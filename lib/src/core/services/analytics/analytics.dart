import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics_service.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:logger/logger.dart';

abstract class Analytics {
  Future<void> logAppOpen();
  Future<void> logLogin(String loginMethod);
  void logError(String msg);
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
  Future<void> logViewItemList();
  Future<void> logViewSearchResults();
  FirebaseAnalyticsObserver getAnalyticsObserver();
  static Logger getLogger(String className) {
    return Logger(printer: DebugLogPrinter(className));
  }

  static void setLogLevel(Level level) {
    Logger.level = level;
  }

  Function get recordError;
  Function get recordFlutterError;
}
