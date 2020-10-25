import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class SocialMediaWidget extends HookWidget {
  final bool isAppleSupported;
  final ValueChanged<bool> authResultCallback;
  const SocialMediaWidget(
      {Key key,
      @required this.authResultCallback,
      this.isAppleSupported = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logger = useProvider(loggerProvider('SocialMediaWidget'));
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: () async {
              final result = await context
                  .read(userRepositoryProvider)
                  .signUpWithFacebook();
              logger.v('SocialLogin result: $result');
              authResultCallback(result);
            },
            child: Image.asset('assets/images/facebook.png'),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: () async {
              final result =
                  await context.read(userRepositoryProvider).signUpWithGoogle();
              logger.v('SocialLogin result: $result');
              authResultCallback(result);
            },
            child: Image.asset('assets/images/google_logo.png'),
          ),
        ),
        SizedBox(width: 10),
        if (isAppleSupported) ...[
          SizedBox(
            width: 45,
            height: 45,
            child: Builder(
              builder: (context) => InkWell(
                onTap: () async {
                  final result = await context
                      .read(userRepositoryProvider)
                      .signUpWithApple();
                  logger.v('SocialLogin result: $result');
                  authResultCallback(result);
                },
                child: Image.asset('assets/images/apple_login.png'),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: () async {
              final result = await context
                  .read(userRepositoryProvider)
                  .signUpAnonymously();
              logger.v('SocialLogin result: $result');
              authResultCallback(result);
            },
            child: Image.asset('assets/images/anonymous.png'),
          ),
        ),
      ],
    );
  }
}
