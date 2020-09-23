import 'dart:io';

import 'package:bottleshopdeliveryapp/src/services/authentication/authentication_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/on_boarding_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/sign_up_view.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/sign_up_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class SplashScreenView extends HookWidget {
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    final AsyncValue<AuthState> authState = useProvider(authStateProvider);
    return authState.when(
      data: (data) {
        if (data == AuthState.LOGGED_IN) {
          return OnBoardingView();
        }
        return SignUpView();
      },
      loading: () => const SplashScreen(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.85),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backround.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/bottleshop-logo.png',
                  color: Theme.of(context).accentColor,
                  height: 300,
                  width: 300),
              if (Platform.isIOS) CupertinoActivityIndicator(radius: 35),
              if (!Platform.isIOS) CircularProgressIndicator(strokeWidth: 2),
            ],
          ),
        ),
      ),
    );
  }
}
