import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/home_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

FirebaseAnalytics _getAnalytics(BuildContext context) =>
    context.read<FirebaseAnalytics>(analyticsProvider);

Future<void> logEvent(BuildContext context, String name,
    {Map<String, dynamic> params}) {
  return _getAnalytics(context).logEvent(name: name, parameters: params);
}

Future<void> setCurrentScreen(BuildContext context, String name) {
  return _getAnalytics(context).setCurrentScreen(screenName: name);
}

Future<void> setUserProperties(BuildContext context,
    {String id, String name, String email}) async {
  await _getAnalytics(context).setUserId(id);
  await _getAnalytics(context).setUserProperty(name: "email", value: email);
  await _getAnalytics(context).setUserProperty(name: "name", value: name);
  return;
}

String analyticsNameExtractor(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.routeName:
      return 'Home page';
      break;
    default:
      return 'Unspecified page';
  }
}
