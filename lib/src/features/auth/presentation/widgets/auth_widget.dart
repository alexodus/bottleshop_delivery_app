import 'package:bottleshopdeliveryapp/src/features/auth/data/repositories/user_repository.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/pages/sign_in_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/pages/splash.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/home_page.dart';
import 'package:bottleshopdeliveryapp/src/features/tutorial/presentation/pages/tutorial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class AuthWidget extends HookWidget {
  const AuthWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useProvider(userRepositoryProvider);
    switch (user.status) {
      case AuthStatus.Unauthenticated:
      case AuthStatus.Authenticating:
        return SignInPage();
        break;
      case AuthStatus.Authenticated:
        if (user.isLoading) {
          return Splash();
        }
        return user.user?.introSeen ?? false ? HomePage() : TutorialPage();
        break;
      case AuthStatus.Uninitialized:
      default:
        return Splash();
    }
  }
}
