import 'dart:io';

import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreenView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Future<User> user = watch(userProvider.last);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.85),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/bottleshop-logo.png',
                color: Theme.of(context).accentColor, height: 300, width: 300),
            if (Platform.isIOS) CupertinoActivityIndicator(radius: 35),
            if (!Platform.isIOS) CircularProgressIndicator(strokeWidth: 2),
          ],
        ),
      ),
    );
  }
}
