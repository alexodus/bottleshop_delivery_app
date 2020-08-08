import 'dart:async';

import 'package:bottleshopdeliveryapp/src/constants/app_theme.dart';
import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/constants/strings.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics_service.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication_service.dart';
import 'package:bottleshopdeliveryapp/src/services/database/firestore_service.dart';
import 'package:bottleshopdeliveryapp/src/services/notifications/push_notification_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/on_boarding_view.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

void main() {
  Crashlytics.instance.enableInDevMode = false;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  Analytics.setLogLevel(Level.verbose);
  runZoned(() {
    runApp(MultiProvider(
      providers: [
        Provider<Authentication>(
          create: (_) => AuthenticationService(),
        ),
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),
        Provider<PushNotificationService>(
          create: (_) => PushNotificationService(),
        ),
        StreamProvider<User>(
          create: (context) =>
              context.read<Authentication>().onAuthStateChanged,
        ),
        Provider<Analytics>(
          create: (_) => AnalyticsService(),
        ),
      ],
      child: MyApp(),
    ));
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logger = Analytics.getLogger('MyApp');
    final observer =
        context.select((Analytics analytics) => analytics.analyticsObserver);
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      title: Strings.appName,
      onGenerateRoute: Routes.onGenerateRoute,
      theme: appTheme,
      darkTheme: appThemeDark,
      themeMode: ThemeMode.system,
      home: Consumer<User>(
        builder: (_, user, __) {
          logger.v('current user: $user');
          if (user == null) {
            observer.analytics.logTutorialBegin();
            return OnBoardingView();
          } else {
            observer.analytics.setUserId(user.uid);
            return TabsView();
          }
        },
      ),
    );
  }
}
