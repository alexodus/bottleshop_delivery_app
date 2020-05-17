import 'dart:async';

import 'package:bottleshopdeliveryapp/src/core/constants/app_theme.dart';
import 'package:bottleshopdeliveryapp/src/core/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics_service.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication_service.dart';
import 'package:bottleshopdeliveryapp/src/core/services/database/database.dart';
import 'package:bottleshopdeliveryapp/src/core/services/database/user_database_service.dart';
import 'package:bottleshopdeliveryapp/src/core/services/preferences/user_preferences.dart';
import 'package:bottleshopdeliveryapp/src/core/services/preferences/user_preferences_service.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/theme_provider_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/onbboarding/on_boarding_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/sign_in/sign_in_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/tabs_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/auth_widget_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Analytics _analytics = AnalyticsService.fromFirebase();
  runZoned(() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProviderService>(
            create: (context) =>
                ThemeProviderService.fromSharedPreferenceService(),
          ),
          Provider<Authentication>(
            create: (context) => AuthenticationService.fromDefault(),
          ),
          Provider<Analytics>.value(value: _analytics),
          Provider<Database<User>>(
              create: (context) => UserDatabaseService.fromFireStore()),
          Provider<UserPreferences>(
              create: (context) =>
                  UserPreferencesService.fromSharedPreferences()),
        ],
        child: MyApp(),
      ),
    );
  }, onError: _analytics.recordError);
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Analytics _analytics = Provider.of<Analytics>(context, listen: false);
    _analytics.logAppOpen();
    return Consumer<ThemeProviderService>(
      builder: (_, themeProviderRef, __) {
        return AuthWidgetBuilder(
          builder: (context, userSnapshot) {
            return MaterialApp(
              navigatorObservers: [_analytics.getAnalyticsObserver()],
              debugShowCheckedModeBanner: false,
              title: 'Bottleshop 3 Veze',
              routes: Routes.routes,
              onUnknownRoute: Routes.onUnknownRoute,
              onGenerateRoute: Routes.onGenerateRoute,
              theme: appTheme,
              darkTheme: appThemeDark,
              themeMode: themeProviderRef.isDarkModeOn
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: _getLandingPage(context),
            );
          },
        );
      },
    );
  }

  Widget _getLandingPage(BuildContext context) {
    final settings = Provider.of<UserPreferences>(context, listen: false);
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TabsScreen();
          } else {
            return FutureBuilder<bool>(
                future: settings.getOnBoardingShown(),
                builder: (_, snapshot) {
                  if (snapshot.hasData && snapshot.data) {
                    return SignInScreen();
                  } else {
                    return OnBoardingScreen();
                  }
                });
          }
        });
  }
}
