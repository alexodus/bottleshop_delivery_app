import 'dart:async';

import 'package:bottleshopdeliveryapp/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(kDebugMode ? false : true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Logger.level = kDebugMode ? Level.verbose : Level.error;
  runZonedGuarded<Future<void>>(() async {
    runApp(
      ProviderScope(
        child: const App(),
      ),
    );
  },
      (Object error, StackTrace stackTrace) =>
          FirebaseCrashlytics.instance.recordError(error, stackTrace));
}
