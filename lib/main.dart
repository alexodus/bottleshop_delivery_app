import 'dart:async';

import 'package:bottleshopdeliveryapp/src/app.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:logger/logger.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(kDebugMode ? false : true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Analytics.setLogLevel(kDebugMode ? Level.verbose : Level.error);
  runZoned(() {
    runApp(
      const ProviderScope(child: MyApp()),
    );
  }, onError: FirebaseCrashlytics.instance.recordError);
}
