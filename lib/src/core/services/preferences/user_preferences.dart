import 'package:bottleshopdeliveryapp/src/core/enums/enums.dart';

abstract class UserPreferences {
  Future<Language> getCurrentLanguage();
  Future<AppTheme> getCurrentTheme();
  Future<bool> getOnBoardingShown();
  Future<void> setCurrentLanguage(Language language);
  Future<void> setCurrentTheme(AppTheme theme);
  Future<void> setOnBoardingShown(bool shown);
}
