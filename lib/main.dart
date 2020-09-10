import 'dart:async';

import 'package:bottleshopdeliveryapp/src/app.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Crashlytics.instance.enableInDevMode = false;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  Analytics.setLogLevel(kDebugMode == true ? Level.verbose : Level.error);
  runZoned(() {
    runApp(
      const ProviderScope(child: MyApp()),
    );
  }, onError: Crashlytics.instance.recordError);
}
