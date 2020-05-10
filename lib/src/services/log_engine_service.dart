import 'package:bottleshopdeliveryapp/src/services/analytics.dart';
import 'package:bottleshopdeliveryapp/src/utils/debug_log_printer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

class LogEngineService extends BaseAnalyticsEngine implements Analytics {
  static final LogEngineService _instance = LogEngineService._internal();

  LogEngineService._internal() {
    firebaseAnalyticsInstance = FirebaseAnalytics();
    crashlyticsInstance = Crashlytics.instance;
  }

  factory LogEngineService() {
    return _instance;
  }

  Function get recordError => _instance.crashlyticsInstance.recordError;
  Function get recordFlutterError =>
      _instance.crashlyticsInstance.recordFlutterError;

  @override
  Future<void> logAppOpen() {
    // TODO: implement logAppOpen
    throw UnimplementedError();
  }

  @override
  Future<void> logError() {
    // TODO: implement logError
    throw UnimplementedError();
  }

  @override
  Future<void> logLogin() {
    // TODO: implement logLogin
    throw UnimplementedError();
  }

  FirebaseAnalyticsObserver getAnalyticsObserver() {
    return FirebaseAnalyticsObserver(
        analytics: _instance.firebaseAnalyticsInstance);
  }

  @override
  Logger getLogger(String className) {
    return Logger(printer: DebugLogPrinter(className));
  }

  @override
  void setLogLevel({Level level = Level.verbose}) {
    Logger.level = level;
  }
}
