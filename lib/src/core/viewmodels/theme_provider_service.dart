import 'package:bottleshopdeliveryapp/src/core/enums/enums.dart';
import 'package:bottleshopdeliveryapp/src/core/services/preferences/user_preferences.dart';
import 'package:bottleshopdeliveryapp/src/core/services/preferences/user_preferences_service.dart';
import 'package:flutter/material.dart';

class ThemeProviderService extends ChangeNotifier {
  final UserPreferences preferencesService;
  AppTheme _currentTheme = AppTheme.system;

  ThemeProviderService({@required this.preferencesService})
      : assert(preferencesService != null);

  factory ThemeProviderService.fromSharedPreferenceService() {
    return ThemeProviderService(
        preferencesService: UserPreferencesService.fromSharedPreferences());
  }

  bool get isDarkModeOn {
    var theme = getTheme();
    if (theme == AppTheme.system &&
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark) {
      return true;
    }
    if (theme == AppTheme.dark) {
      return true;
    }
    return false;
  }

  AppTheme getTheme() {
    preferencesService.getCurrentTheme().then((theme) => _currentTheme = theme);
    return _currentTheme;
  }

  void updateTheme(AppTheme theme) {
    preferencesService
        .setCurrentTheme(theme)
        .then((_) => preferencesService.getCurrentTheme())
        .then((theme) {
      _currentTheme = theme;
      notifyListeners();
    });
  }
}
