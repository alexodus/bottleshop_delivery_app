import 'package:flutter/material.dart';

class Preferences {
  static const String language = 'lang';
  static const String theme = 'theme';
  static const String onBoardingShown = 'onboarding';
}

class Constants {
  static const defaultAvatar = 'assets/images/avatar.png';
  static const facebookPermissions = ['public_profile', 'email'];
  static const usersCollection = '/users/';
  static const String firebaseProjectURL =
      'https://fir-auth-demo-flutter.firebaseapp.com/';
  // Vertical spacing constants. Adjust to your liking.
  static const double _verticalSpaceSmall = 10.0;
  static const double _verticalSpaceMedium = 20.0;
  static const double _verticalSpaceLarge = 60.0;

  // Vertical spacing constants. Adjust to your liking.
  static const double _horizontalSpaceSmall = 10.0;
  static const double hHorizontalSpaceMedium = 20.0;
  static const double hHorizontalSpaceLarge = 60.0;

  static const Widget verticalSpaceSmall =
      SizedBox(height: _verticalSpaceSmall);
  static const Widget verticalSpaceMedium =
      SizedBox(height: _verticalSpaceMedium);
  static const Widget verticalSpaceLarge =
      SizedBox(height: _verticalSpaceLarge);

  static const Widget horizontalSpaceSmall =
      SizedBox(width: _horizontalSpaceSmall);
  static const Widget horizontalSpaceMedium =
      SizedBox(width: hHorizontalSpaceMedium);
  static const Widget horizontalSpaceLarge =
      SizedBox(width: hHorizontalSpaceLarge);
}
