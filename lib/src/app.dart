import 'package:bottleshopdeliveryapp/src/services/analytics/analytics_service.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/app_theme.dart';
import 'constants/routes.dart';
import 'constants/strings.dart';

final userProvider = StreamProvider.autoDispose<AuthState>((ref) {
  return AuthenticationService().authStateChanges;
});

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              'Cloud connection fatal error :-(',
              style: TextStyle(color: Colors.yellow),
              textDirection: TextDirection.ltr,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            navigatorObservers: <NavigatorObserver>[
              AnalyticsService().analyticsObserver
            ],
            title: Strings.appName,
            onGenerateRoute: Routes.onGenerateRoute,
            theme: appTheme,
            darkTheme: appThemeDark,
            themeMode: ThemeMode.system,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
