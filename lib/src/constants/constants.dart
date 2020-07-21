import 'package:bottleshopdeliveryapp/src/models/language_model.dart';

class Constants {
  static const defaultAvatar = 'assets/images/avatar.png';
  static const facebookPermissions = ['public_profile', 'email'];
  static const usersCollection = 'users';
  static const language = 'lang';
  static const onBoardingShown = 'onboarding';
  static List<LanguageModel> get languages => [
        LanguageModel("English", "English", "assets/images/united-states-of-america.png"),
        LanguageModel("Slovak", "Slovenčina", "assets/images/slovakia.png")
      ];
  static String cloudStorageBucket = 'gs://bottleshop3veze-delivery.appspot.com';
}
