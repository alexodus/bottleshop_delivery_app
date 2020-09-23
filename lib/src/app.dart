import 'package:bottleshopdeliveryapp/src/constants/app_theme.dart';
import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/constants/strings.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/splash_screen_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/fatal_error.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);
    Analytics.setLogLevel(kDebugMode ? Level.verbose : Level.error);
    AnalyticsService().setAnalyticsCollectionEnabled(!kDebugMode);
    Function originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      originalOnError(errorDetails);
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return FatalError(errorMessage: 'Connection to cloud failed');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            navigatorObservers: [AnalyticsService().analyticsObserver],
            title: Strings.appName,
            onGenerateRoute: Routes.onGenerateRoute,
            theme: appTheme,
            darkTheme: appThemeDark,
            themeMode: ThemeMode.system,
            initialRoute: SplashScreenView.routeName,
          );
        }
        return SplashScreen();
      },
    );
  }
}
