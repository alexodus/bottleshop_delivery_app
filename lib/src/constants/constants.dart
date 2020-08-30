import 'package:bottleshopdeliveryapp/src/models/language_model.dart';

class Constants {
  static const defaultAvatar = 'assets/images/avatar.png';
  static const defaultProductPic = 'assets/images/generic.png';
  static const defaultProductThumbnail = 'assets/images/generic_thumbnail.png';
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
  static const unitsCollection = 'units';
  static const orderTypesCollection = 'order_types';
  static const ordersCollection = 'orders';
  static List<LanguageModel> get languages => [
        LanguageModel(
          englishName: 'English',
          localName: 'English',
          flag: 'assets/images/united-states-of-america.png',
        ),
        LanguageModel(
            englishName: 'Slovak',
            localName: 'Slovenčina',
            flag: 'assets/images/slovakia.png')
      ];
  static String cloudStorageBucket =
      'gs://bottleshop3veze-delivery.appspot.com';
  static const configurationCollection = 'configuration';
  static const cartCollection = 'cart';
  static const favoritesCollection = 'favorites';
  static const stripeCloudFunctionUrl =
      'https://us-central1-bottleshop3veze-delivery.cloudfunctions.net/verifyPayment';
  static const applePayMerchantId =
      'merchant.sk.bottleshop3veze.bottleshopdeliveryapp';
  static const stripePublishableKey =
      'pk_test_Gnq83EyihTQEkX5vR7Mlf3Ec00jzaAL91B';
  static const stripeAndroidPayMode = 'test';
  static const stripeSupportedCards = [
    'american_express',
    'visa',
    'maestro',
    'master_card',
  ];
}
