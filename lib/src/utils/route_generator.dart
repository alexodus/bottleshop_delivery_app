import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/screens/brand.dart';
import 'package:bottleshopdeliveryapp/src/screens/brands.dart';
import 'package:bottleshopdeliveryapp/src/screens/cart.dart';
import 'package:bottleshopdeliveryapp/src/screens/categories.dart';
import 'package:bottleshopdeliveryapp/src/screens/category.dart';
import 'package:bottleshopdeliveryapp/src/screens/checkout.dart';
import 'package:bottleshopdeliveryapp/src/screens/checkout_done.dart';
import 'package:bottleshopdeliveryapp/src/screens/help.dart';
import 'package:bottleshopdeliveryapp/src/screens/languages.dart';
import 'package:bottleshopdeliveryapp/src/screens/on_boarding_screen.dart';
import 'package:bottleshopdeliveryapp/src/screens/orders.dart';
import 'package:bottleshopdeliveryapp/src/screens/product.dart';
import 'package:bottleshopdeliveryapp/src/screens/sign_in_screen.dart';
import 'package:bottleshopdeliveryapp/src/screens/sign_up_screen.dart';
import 'package:bottleshopdeliveryapp/src/screens/splash_screen.dart';
import 'package:bottleshopdeliveryapp/src/screens/tabs.dart';
import 'package:flutter/material.dart';

class RoutePaths {
  static dynamic initial() {
    return {
      '/': (context) => SplashScreen(),
    };
  }

  static const String onBoarding = '/onboarding';
  static const String signUp = '/signup';
  static const String signIn = '/signin';
  static const String tabs = '/tabs';
  static const String categories = '/categories';
  static const String orders = '/orders';
  static const String brands = '/brands';
  static const String brandDetail = '/brandDetail';
  static const String categoryDetail = '/categoryDetail';
  static const String products = '/product';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String checkoutCompleted = '/checkoutDone';
  static const String help = '/help';
  static const String languages = '/languages';
}

class RouteGenerator {
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.96),
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Get out'),
        ),
      );
    });
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case RoutePaths.onBoarding:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case RoutePaths.signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case RoutePaths.signIn:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case RoutePaths.categories:
        return MaterialPageRoute(builder: (_) => CategoriesScreen());
      case RoutePaths.orders:
        return MaterialPageRoute(builder: (_) => OrdersScreen());
      case RoutePaths.brands:
        return MaterialPageRoute(builder: (_) => BrandsScreen());
      case RoutePaths.tabs:
        return MaterialPageRoute(
            builder: (_) => TabsScreen(
                  currentTab: args,
                ));
      case RoutePaths.categoryDetail:
        return MaterialPageRoute(
            builder: (_) =>
                CategoryDetailScreen(routeArgument: args as RouteArgument));
      case RoutePaths.brandDetail:
        return MaterialPageRoute(
            builder: (_) =>
                BrandDetailScreen(routeArgument: args as RouteArgument));
      case RoutePaths.products:
        return MaterialPageRoute(
            builder: (_) =>
                ProductDetailScreen(routeArgument: args as RouteArgument));
      case RoutePaths.cart:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case RoutePaths.checkout:
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case RoutePaths.checkoutCompleted:
        return MaterialPageRoute(builder: (_) => CheckoutDoneScreen());
      case RoutePaths.help:
        return MaterialPageRoute(builder: (_) => HelpScreen());
      case RoutePaths.languages:
        return MaterialPageRoute(builder: (_) => LanguagesScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return onUnknownRoute(RouteSettings(name: '/404'));
    }
  }
}
