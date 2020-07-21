import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static final Color _primaryDarkColor = Color(0xFF252525);
  static final Color _mainDarkColor = Color(0xFFCF8100);
  static final Color _secondDarkColor = Color(0xFFC29E00);
  static final Color _accentDarkColor = Color(0xFFdbdbdb);

  static Color primaryDarkColor(double opacity) {
    return AppColors._primaryDarkColor.withOpacity(opacity);
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

final appThemeCupertino = CupertinoThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.mainDarkColor(1),
  primaryContrastingColor: AppColors.accentDarkColor(1),
  barBackgroundColor: AppColors.primaryDarkColor(1),
  scaffoldBackgroundColor: AppColors.primaryDarkColor(1),
  textTheme: CupertinoTextThemeData().copyWith(textStyle: GoogleFonts.poppins()),
);

final appThemeDark = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
  primaryColor: AppColors.primaryDarkColor(1),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.primaryDarkColor(1),
  accentColor: AppColors.mainDarkColor(1),
  hintColor: AppColors.secondDarkColor(1),
  focusColor: AppColors.accentDarkColor(1),
  textTheme: GoogleFonts.poppinsTextTheme(
    TextTheme(
      button: TextStyle(color: AppColors.primaryDarkColor(1)),
      headline5: TextStyle(fontSize: 20.0, color: AppColors.secondDarkColor(1)),
      headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.secondDarkColor(1)),
      headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: AppColors.secondDarkColor(1)),
      headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: AppColors.mainDarkColor(1)),
      headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: AppColors.secondDarkColor(1)),
      subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: AppColors.secondDarkColor(1)),
      headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: AppColors.mainDarkColor(1)),
      bodyText2: TextStyle(fontSize: 12.0, color: AppColors.secondDarkColor(1)),
      bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.secondDarkColor(1)),
      caption: TextStyle(fontSize: 12.0, color: AppColors.secondDarkColor(0.7)),
    ),
  ),
);
