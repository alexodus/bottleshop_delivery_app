import 'package:bottleshopdeliveryapp/generated/l10n.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/analytics_service.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/res/app_theme.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/res/routes.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/widgets/auth_widget.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/all.dart';

class App extends HookWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read(analyticsProvider).setAnalyticsCollectionEnabled(!kDebugMode);
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      navigatorObservers: [
        FirebaseAnalyticsObserver(
          analytics: useProvider(analyticsProvider),
          nameExtractor: analyticsNameExtractor,
        ),
      ],
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => S.of(context).app_title,
      theme: appTheme,
      darkTheme: appThemeDark,
      themeMode: ThemeMode.system,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: AuthWidget(),
    );
  }
}
