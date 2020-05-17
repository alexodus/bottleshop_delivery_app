import 'package:bottleshopdeliveryapp/src/core/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/enums/enums.dart';
import 'package:bottleshopdeliveryapp/src/core/services/preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService implements UserPreferences {
  final Future<SharedPreferences> preferences;

  UserPreferencesService({@required this.preferences})
      : assert(preferences != null);

  factory UserPreferencesService.fromSharedPreferences() {
    return UserPreferencesService(preferences: SharedPreferences.getInstance());
  }

  @override
  Future<Language> getCurrentLanguage() async {
    var prefs = await preferences;
    return Language.values[prefs.getInt(Preferences.language) ?? 0];
  }

  @override
  Future<AppTheme> getCurrentTheme() async {
    var prefs = await preferences;
    return AppTheme.values[prefs.getInt(Preferences.theme) ?? 0];
  }

  @override
  Future<bool> getOnBoardingShown() async {
    var prefs = await preferences;
    return prefs.getBool(Preferences.onBoardingShown) ?? false;
  }

  @override
  Future<void> setCurrentLanguage(Language language) async {
    var prefs = await preferences;
    await prefs.setInt(Preferences.language, language.index);
  }

  @override
  Future<void> setCurrentTheme(AppTheme theme) async {
    var prefs = await preferences;
    await prefs.setInt(Preferences.theme, theme.index);
  }

  @override
  Future<void> setOnBoardingShown(bool shown) async {
    var prefs = await preferences;
    await prefs.setBool(Preferences.onBoardingShown, shown);
  }
}
