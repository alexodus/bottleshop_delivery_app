import 'package:flutter/material.dart';

class Constants {
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
