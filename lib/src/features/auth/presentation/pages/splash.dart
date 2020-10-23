import 'dart:io';

import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class Splash extends HookWidget {
  static const routeName = '/splash';
  @override
  Widget build(BuildContext context) {
    final errorMode =
        useProvider(userRepositoryProvider.select((value) => value.error));
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.85),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 200),
              if (errorMode.isEmpty) _platformLoader(context),
              if (errorMode.isNotEmpty)
                Text(
                  'Oops, something went horribly wrong...',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _platformLoader(BuildContext context) {
    return Platform.isIOS
        ? CupertinoActivityIndicator(radius: 35)
        : CircularProgressIndicator(strokeWidth: 2);
  }
}
