import 'dart:async';

import 'package:bottleshopdeliveryapp/src/constants/app_theme.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/firebase_auth_service.dart';
import 'package:bottleshopdeliveryapp/src/services/log_engine_service.dart';
import 'package:bottleshopdeliveryapp/src/state/AuthState.dart';
import 'package:bottleshopdeliveryapp/src/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

void main() {
  var logEngine = LogEngineService();
  logEngine.setLogLevel(level: Level.verbose);
  FlutterError.onError = logEngine.recordFlutterError;
  runZoned(() {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
  }, onError: logEngine.recordError);
}

class MyApp extends StatelessWidget {
  get providers => null;

  get dispose => null;

  final authentication = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Analytics>(create: (_) => LogEngineService()),
        ChangeNotifierProvider<AuthState>(
            create: (_) => AuthState(authentication: authentication)),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        title: 'Bottleshop 3 Veze',
        debugShowCheckedModeBanner: false,
        initialRoute: RoutePaths.splash,
        onGenerateRoute: RouteGenerator.onGenerateRoute,
        navigatorObservers: <NavigatorObserver>[
          LogEngineService().getAnalyticsObserver(),
        ],
        darkTheme: appThemeDark,
        theme: appTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
