import 'package:bottleshopdeliveryapp/src/core/enums/enums.dart';
import 'package:bottleshopdeliveryapp/src/core/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/cart/cart.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/categories/categories.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/category_detail/category.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/checkout/checkout.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/checkout_done/checkout_done.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/help/help.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/languages/languages.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/onbboarding/on_boarding_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/orders/orders.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/product_detail/product.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/reset_password/reset_password_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/sign_in/sign_in_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/sign_up/sign_up_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/splash/splash_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/account_tab.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/favorites_tab.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/home_tab.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/notifications_tab.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/tabs_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiating this object
  static final routes = <String, WidgetBuilder>{
    CartScreen.routeName: (builder) => CartScreen(),
    CategoriesScreen.routeName: (builder) => CategoriesScreen(),
    CategoryDetailScreen.routeName: (builder) => CategoryDetailScreen(),
    CheckoutScreen.routeName: (builder) => CheckoutScreen(),
    CheckoutDoneScreen.routeName: (builder) => CheckoutDoneScreen(),
    HelpScreen.routeName: (builder) => HelpScreen(),
    LanguagesScreen.routeName: (builder) => LanguagesScreen(),
    OnBoardingScreen.routeName: (builder) => OnBoardingScreen(),
    OrdersScreen.routeName: (builder) => OrdersScreen(),
    ProductDetailScreen.routeName: (builder) => ProductDetailScreen(),
    SignInScreen.routeName: (builder) => SignInScreen(),
    SignUpScreen.routeName: (builder) => SignUpScreen(),
    ResetPasswordScreen.routeName: (builder) => ResetPasswordScreen(),
    TabsScreen.routeName: (builder) => TabsScreen(),
    AppSplashScreen.routeName: (_) => AppSplashScreen(),
  };

  static final tabs = <TabIndex, Widget>{
    TabIndex.notifications: NotificationsTab(), // 0
    TabIndex.account: AccountTab(), // 1
    TabIndex.home: HomeTab(), // 2
    TabIndex.favorites: FavoritesTab(),
    TabIndex.myOrders: OrdersScreen(currentTab: 0) // 3
  };

  static RouteArgument onTabSelection(TabIndex tab) {
    switch (tab) {
      case TabIndex.notifications:
        return RouteArgument(
            title: 'Notifications',
            id: TabIndex.notifications.index,
            argumentsList: [NotificationsTab()]);
        break;
      case TabIndex.account:
        return RouteArgument(
            title: 'Account',
            id: TabIndex.account.index,
            argumentsList: [AccountTab()]);
        break;
      case TabIndex.home:
        return RouteArgument(
            title: 'Home', id: TabIndex.home.index, argumentsList: [HomeTab()]);
        break;
      case TabIndex.favorites:
        return RouteArgument(
            title: 'Favorites',
            id: TabIndex.favorites.index,
            argumentsList: [FavoritesTab()]);
        break;
      case TabIndex.myOrders:
        return RouteArgument(
            title: 'My Orders',
            id: TabIndex.myOrders.index,
            argumentsList: [
              OrdersScreen(currentTab: 0),
            ]);
        break;
      default:
        return RouteArgument(
            title: 'Home', id: TabIndex.home.index, argumentsList: [HomeTab()]);
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.96),
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text(settings.name),
        ),
      );
    });
  }
}
