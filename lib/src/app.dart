import 'package:bottleshopdeliveryapp/src/constants/app_theme.dart';
import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/constants/strings.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/splash_screen_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [AnalyticsService().analyticsObserver],
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      onGenerateRoute: Routes.onGenerateRoute,
      theme: appTheme,
      darkTheme: appThemeDark,
      themeMode: ThemeMode.system,
      home: SplashScreenView(),
    );
  }
}
