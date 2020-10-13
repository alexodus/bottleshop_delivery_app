import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication_service.dart';
import 'package:hooks_riverpod/all.dart';

final authProvider =
    Provider<AuthenticationService>((_) => AuthenticationService());

final authStateChangesProvider =
    StreamProvider<User>((ref) => ref.watch(authProvider).authStateChanges);
