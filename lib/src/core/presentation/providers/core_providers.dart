import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/push_notification_service.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/stripe_service.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/services/authentication_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:logger/logger.dart';

final authProvider =
    Provider<AuthenticationService>((_) => AuthenticationService());
final pushNotificationsProvider =
    Provider<PushNotificationService>((_) => PushNotificationService());
final stripeProvider = Provider<StripeService>((_) => StripeService());
final analyticsProvider = Provider((ref) => FirebaseAnalytics());
final loggerProvider = Provider.family<Logger, String>(
    (ref, className) => createLogger(className));
