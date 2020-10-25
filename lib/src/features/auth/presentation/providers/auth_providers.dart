import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/repositories/user_repository.dart';
import 'package:hooks_riverpod/all.dart';

final currentUserProvider =
    Provider((ref) => ref.watch(userRepositoryProvider).user);

final appleSignInAvailableProvider = FutureProvider<bool>((ref) async {
  final auth = await ref.watch(authProvider).supportsAppleSignIn;
  return auth;
});

final userRepositoryProvider = ChangeNotifierProvider<UserRepository>((ref) {
  final auth = ref.watch(authProvider);
  final push = ref.watch(pushNotificationsProvider);
  return UserRepository.instance(auth, push);
});
