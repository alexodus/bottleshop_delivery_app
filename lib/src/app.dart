import 'package:bottleshopdeliveryapp/src/core/presentation/res/app_theme.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/res/routes.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'core/data/services/analytics_service.dart';
import 'core/presentation/providers/core_providers.dart';
import 'features/auth/presentation/widgets/auth_widget.dart';

class App extends HookWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read(analyticsProvider).setAnalyticsCollectionEnabled(!kDebugMode);
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(
          analytics: useProvider(analyticsProvider),
          nameExtractor: analyticsNameExtractor,
        ),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Bottleshop',
      theme: appTheme,
      darkTheme: appThemeDark,
      themeMode: ThemeMode.system,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: AuthWidget(),
    );
  }
}
