class AppConstants {
  static const defaultAvatar = 'assets/images/avatar.png';
  static const defaultProductPic = 'assets/images/generic.png';
  static const defaultProductThumbnail = 'assets/images/generic_thumbnail.png';
  static const facebookPermissions = ['public_profile', 'email'];
  static const googleSignInScopes = [
    'https://www.googleapis.com/auth/userinfo.email',
    'https://www.googleapis.com/auth/userinfo.profile',
    'openid'
  ];
  static const appleSignInClientId = 'sk.bottleshop3veze.applesignin';
  static const appleSignInRedirectUri =
      'https://bottleshop3veze-delivery.firebaseapp.com/__/auth/handler';

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

class AppAnalyticsEvents {
  static const String logOut = "log_out";
}

class AnalyticsScreenNames {
  static const String welcome = "Welcome page";
  static const String splash = "Splash screen";
  static const String login = "Login Screen";
  static const String userInfo = "User profile";
  static const String root = "Root page";
}

class Keys {
  static const String tabBar = 'tabBar';
  static const String favoritesTab = 'favoritesTab';
  static const String productsTab = 'productsTab';
  static const String accountTab = 'ordersTab';
}
