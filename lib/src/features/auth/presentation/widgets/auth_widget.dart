import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
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
    final authStatus =
        useProvider(userRepositoryProvider.select((value) => value.status));
    final isLoading =
        useProvider(userRepositoryProvider.select((value) => value.isLoading));
    final logger = useProvider(loggerProvider('AuthWidget'));
    logger.v('current status: ${authStatus.toString()}');
    switch (authStatus) {
      case AuthStatus.Unauthenticated:
      case AuthStatus.Authenticating:
        return SignInPage();
        break;
      case AuthStatus.Authenticated:
        if (isLoading) {
          logger.v('authenticated but still loading: $isLoading');
          return Splash();
        }
        final isNotRoot = Navigator.of(context).canPop();
        logger.v('on route: $isNotRoot');
        final user =
            useProvider(userRepositoryProvider.select((value) => value.user));
        logger.v('current user: ${user.toString()}');
        return user?.introSeen ?? false ? HomePage() : TutorialPage();
        break;
      case AuthStatus.Uninitialized:
      default:
        logger.v('in default');
        return Splash();
    }
  }
}
