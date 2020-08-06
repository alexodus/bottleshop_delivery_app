import 'package:bottleshopdeliveryapp/src/models/language_model.dart';

class Constants {
  static const defaultAvatar = 'assets/images/avatar.png';
  static const facebookPermissions = ['public_profile', 'email'];
  static const googleSignInScopes = [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
    'openid'
  ];
  static const usersCollection = 'users';
  static const productsCollection = 'warehouse';
  static const categoriesCollection = 'categories';
  static const countriesCollection = 'countries';
  static List<LanguageModel> get languages => [
        LanguageModel(
            "English", "English", "assets/images/united-states-of-america.png"),
        LanguageModel("Slovak", "Slovenčina", "assets/images/slovakia.png")
      ];
  static String cloudStorageBucket =
      'gs://bottleshop3veze-delivery.appspot.com';
}
