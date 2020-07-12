import 'package:bottleshopdeliveryapp/src/core/constants/app_theme.dart';
import 'package:bottleshopdeliveryapp/src/core/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/core/constants/strings.dart';
import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics_service.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/onboarding/on_boarding_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider<Authentication>(
            create: (_) => AuthenticationService(),
          ),
          StreamProvider<User>(
            create: (context) => context.read<Authentication>().onAuthStateChanged,
            initialData: null,
          ),
          Provider<Analytics>(
            create: (_) => AnalyticsService(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Analytics.setLogLevel(Level.verbose);
    final logger = Analytics.getLogger('MyApp');
    final NavigatorObserver observer = Provider.of<Analytics>(context, listen: false).getAnalyticsObserver();
    return MaterialApp(
      navigatorObservers: [observer],
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      routes: Routes.routes,
      onUnknownRoute: Routes.onUnknownRoute,
      onGenerateRoute: Routes.onGenerateRoute,
      theme: appThemeDark,
      home: Consumer<User>(
        builder: (_, user, __) {
          logger.v('current user: $user');
          if (user == null) {
            return OnBoardingScreen();
          } else {
            return TabsScreen();
          }
        },
      ),
    );
  }
}
