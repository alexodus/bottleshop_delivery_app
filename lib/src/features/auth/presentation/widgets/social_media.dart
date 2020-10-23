import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class SocialMediaWidget extends HookWidget {
  final bool isAppleSupported;
  SocialMediaWidget({Key key, this.isAppleSupported = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: () async {
              if (!await context
                  .read(userRepositoryProvider)
                  .signUpWithFacebook()) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sing in failed, please try again'),
                  ),
                );
              }
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
              if (!await context
                  .read(userRepositoryProvider)
                  .signUpWithGoogle()) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sing in failed, please try again'),
                  ),
                );
              }
            },
            child: Image.asset('assets/images/google_logo.png'),
          ),
        ),
        SizedBox(width: 10),
        if (isAppleSupported) ...[
          SizedBox(
            width: 45,
            height: 45,
            child: InkWell(
              onTap: () async {
                if (!await context
                    .read(userRepositoryProvider)
                    .signUpWithApple()) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sing in failed, please try again'),
                    ),
                  );
                }
              },
              child: Image.asset('assets/images/apple_login.png'),
            ),
          ),
          SizedBox(width: 10),
        ],
        SizedBox(
          width: 45,
          height: 45,
          child: InkWell(
            onTap: () async {
              if (!await context
                  .read(userRepositoryProvider)
                  .signUpAnonymously()) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sing in failed, please try again'),
                  ),
                );
              }
            },
            child: Image.asset('assets/images/anonymous.png'),
          ),
        ),
      ],
    );
  }
}
