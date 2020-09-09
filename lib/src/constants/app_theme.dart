import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static final Color _mainColor = Color(0xFFfcba00);
  static final Color _mainDarkColor = Color(0xFFfcba00);
  static final Color _secondColor = Color(0xFFb83b5e);
  static final Color _secondDarkColor = Color(0xFF655C91);
  static final Color _accentColor = Color(0xFF7CB3C8);
  static final Color _accentDarkColor = Color(0xFF355361);

  static Color mainColor(double opacity) {
    return AppColors._mainColor.withOpacity(opacity);
  }

  static Color secondColor(double opacity) {
    return AppColors._secondColor.withOpacity(opacity);
  }

  static Color accentColor(double opacity) {
    return AppColors._accentColor.withOpacity(opacity);
  }

  static Color mainDarkColor(double opacity) {
    return AppColors._mainDarkColor.withOpacity(opacity);
  }

  static Color secondDarkColor(double opacity) {
    return AppColors._secondDarkColor.withOpacity(opacity);
  }

  static Color accentDarkColor(double opacity) {
    return AppColors._accentDarkColor.withOpacity(opacity);
  }
}

final appTheme = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  accentColor: AppColors.mainColor(1),
  focusColor: AppColors.accentColor(0.8),
  hintColor: AppColors.secondColor(1),
  textTheme: GoogleFonts.poppinsTextTheme(
    TextTheme(
      button: TextStyle(color: Colors.white),
      headline5: TextStyle(fontSize: 20.0, color: AppColors.secondColor(1)),
      headline4: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.secondColor(1)),
      headline3: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: AppColors.accentColor(0.8)),
      headline2: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          color: AppColors.mainColor(1)),
      headline1: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w300,
          color: AppColors.secondColor(1)),
      subtitle1: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: AppColors.accentColor(0.8)),
      headline6: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: AppColors.secondColor(1.0)),
      bodyText2: TextStyle(fontSize: 12.0, color: AppColors.secondColor(1)),
      bodyText1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: AppColors.secondColor(1)),
      caption: TextStyle(fontSize: 12.0, color: AppColors.secondColor(0.6)),
    ),
  ),
);

final appThemeDark = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: Color(0xFF252525),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF2C2C2C),
  accentColor: AppColors.mainDarkColor(1),
  hintColor: AppColors.secondDarkColor(1),
  focusColor: AppColors.accentDarkColor(1),
  textTheme: GoogleFonts.poppinsTextTheme(
    TextTheme(
      button: TextStyle(color: Color(0xFF252525)),
      headline5: TextStyle(fontSize: 20.0, color: AppColors.secondDarkColor(1)),
      headline4: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: AppColors.secondDarkColor(1)),
      headline3: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: AppColors.secondDarkColor(1)),
      headline2: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          color: AppColors.mainDarkColor(1)),
      headline1: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w300,
          color: AppColors.secondDarkColor(1)),
      subtitle1: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: AppColors.secondDarkColor(1)),
      headline6: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: AppColors.mainDarkColor(1)),
      bodyText2: TextStyle(fontSize: 12.0, color: AppColors.secondDarkColor(1)),
      bodyText1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: AppColors.secondDarkColor(1)),
      caption: TextStyle(fontSize: 12.0, color: AppColors.secondDarkColor(0.7)),
    ),
  ),
);
