import 'dart:io';

import 'package:bottleshopdeliveryapp/src/screens/tabs.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication.dart';
import 'package:bottleshopdeliveryapp/src/state/AuthState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer();
    });
    super.initState();
  }

  void timer() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      var state = Provider.of<AuthState>(context, listen: false);
      state.getCurrentUser();
    });
  }

  Widget _body() {
    return Center(
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/bottleshop-logo.png',
            color: Theme.of(context).accentColor,
            height: 300,
            width: 300,
          ),
          Platform.isIOS
              ? CupertinoActivityIndicator(
                  radius: 35,
                )
              : CircularProgressIndicator(
                  strokeWidth: 2,
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.85),
        body: state.authStatus == AuthenticationStatus.NOT_DETERMINED
            ? _body()
            : state.authStatus == AuthenticationStatus.NOT_LOGGED_IN
                ? OnBoardingScreen()
                : TabsScreen(currentTab: 2));
  }
}
