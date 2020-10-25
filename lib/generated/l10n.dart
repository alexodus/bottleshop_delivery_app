// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Already have an account?`
  String get account_already {
    return Intl.message(
      'Already have an account?',
      name: 'account_already',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get add_to_cart {
    return Intl.message(
      'Add to cart',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Amount is incorrect`
  String get amount_incorrect {
    return Intl.message(
      'Amount is incorrect',
      name: 'amount_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Application Preferences`
  String get app_preferences {
    return Intl.message(
      'Application Preferences',
      name: 'app_preferences',
      desc: '',
      args: [],
    );
  }

  /// `Bottleshop 3 Towers`
  String get app_title {
    return Intl.message(
      'Bottleshop 3 Towers',
      name: 'app_title',
      desc: 'Main title',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Clear All`
  String get clear_all {
    return Intl.message(
      'Clear All',
      name: 'clear_all',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Payment`
  String get confirm_payment {
    return Intl.message(
      'Confirm Payment',
      name: 'confirm_payment',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid`
  String get email_invalid {
    return Intl.message(
      'Email is invalid',
      name: 'email_invalid',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Faq`
  String get faq {
    return Intl.message(
      'Faq',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Field is not empty`
  String get field_not_empty {
    return Intl.message(
      'Field is not empty',
      name: 'field_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get help_support {
    return Intl.message(
      'Help & Support',
      name: 'help_support',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `In Dispute`
  String get in_dispute {
    return Intl.message(
      'In Dispute',
      name: 'in_dispute',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Misc`
  String get misc {
    return Intl.message(
      'Misc',
      name: 'misc',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get my_orders {
    return Intl.message(
      'My Orders',
      name: 'my_orders',
      desc: '',
      args: [],
    );
  }

  /// `Name is invalid`
  String get name_invalid {
    return Intl.message(
      'Name is invalid',
      name: 'name_invalid',
      desc: '',
      args: [],
    );
  }

  /// `You do not have any ordered items`
  String get no_orders {
    return Intl.message(
      'You do not have any ordered items',
      name: 'no_orders',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Or Checkout With`
  String get or_checkout {
    return Intl.message(
      'Or Checkout With',
      name: 'or_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Or using social media`
  String get or_social_media {
    return Intl.message(
      'Or using social media',
      name: 'or_social_media',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get password_forgotten {
    return Intl.message(
      'Forgot your password?',
      name: 'password_forgotten',
      desc: '',
      args: [],
    );
  }

  /// `Passwords doesn't match`
  String get password_no_match {
    return Intl.message(
      'Passwords doesn\'t match',
      name: 'password_no_match',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short`
  String get password_short {
    return Intl.message(
      'Password is too short',
      name: 'password_short',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Select your prefered payment mode`
  String get preferred_payment {
    return Intl.message(
      'Select your prefered payment mode',
      name: 'preferred_payment',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Product review`
  String get product_review {
    return Intl.message(
      'Product review',
      name: 'product_review',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Related Poducts`
  String get related_products {
    return Intl.message(
      'Related Poducts',
      name: 'related_products',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Sales`
  String get sales {
    return Intl.message(
      'Sales',
      name: 'sales',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Shipped`
  String get shipped {
    return Intl.message(
      'Shipped',
      name: 'shipped',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get shopping_cart {
    return Intl.message(
      'Shopping Cart',
      name: 'shopping_cart',
      desc: '',
      args: [],
    );
  }

  /// `Sign in failed, please try again`
  String get sign_failure {
    return Intl.message(
      'Sign in failed, please try again',
      name: 'sign_failure',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message(
      'Sign Up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Slovak`
  String get slovak {
    return Intl.message(
      'Slovak',
      name: 'slovak',
      desc: '',
      args: [],
    );
  }

  /// `Start Shopping`
  String get start_shopping {
    return Intl.message(
      'Start Shopping',
      name: 'start_shopping',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Your payment was successfully processed`
  String get successful_payment {
    return Intl.message(
      'Your payment was successfully processed',
      name: 'successful_payment',
      desc: '',
      args: [],
    );
  }

  /// `TAX (20%)`
  String get tax {
    return Intl.message(
      'TAX (20%)',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `To be shipped`
  String get to_be_shipped {
    return Intl.message(
      'To be shipped',
      name: 'to_be_shipped',
      desc: '',
      args: [],
    );
  }

  /// `Unpaid`
  String get unpaid {
    return Intl.message(
      'Unpaid',
      name: 'unpaid',
      desc: '',
      args: [],
    );
  }

  /// `Value is not a number`
  String get value_not_number {
    return Intl.message(
      'Value is not a number',
      name: 'value_not_number',
      desc: '',
      args: [],
    );
  }

  /// `Verify your quantity and click checkout`
  String get verify_quantity {
    return Intl.message(
      'Verify your quantity and click checkout',
      name: 'verify_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Wish List`
  String get wish_list {
    return Intl.message(
      'Wish List',
      name: 'wish_list',
      desc: '',
      args: [],
    );
  }

  /// `Your Orders`
  String get your_orders {
    return Intl.message(
      'Your Orders',
      name: 'your_orders',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account ?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account ?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'sk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}