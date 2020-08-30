import 'dart:io';

import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/favorites_tab.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/home_tab.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/orders_tab.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/account_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/cart_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/categories_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/category_detail_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/checkout_done.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/checkout_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/help_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/languages_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/notifications_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/on_boarding_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/product_detail_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/reset_password_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/sign_in_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/sign_up_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabIndex { favorites, home, orders }
enum OrderTabIndex { all, shipped, toBeShipped, inDispute }

class Routes {
  Routes._(); //this is to prevent anyone from instantiating this object

  static final tabs = <TabIndex, Widget>{
    TabIndex.favorites: FavoritesTab(), //0
    TabIndex.home: HomeTab(), // 1
    TabIndex.orders: OrdersTab() // 2
  };

  static RouteArgument onTabSelection(TabIndex tab, [dynamic args]) {
    switch (tab) {
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
      case TabIndex.orders:
        return RouteArgument(
            title: 'My Orders',
            id: TabIndex.orders.index,
            argumentsList: [
              OrdersTab(),
              args ?? OrderTabIndex.all,
            ]);
        break;
      default:
        return RouteArgument(
            title: 'Home', id: TabIndex.home.index, argumentsList: [HomeTab()]);
    }
  }

  // ignore: missing_return
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final RouteArgument args = settings.arguments;
    switch (settings.name) {
      case AccountView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: AccountView());
        break;
      case NotificationsView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: NotificationsView());
        break;
      case CategoryDetailView.routeName:
        return _getPageRoute(
            routeName: settings.name,
            viewToShow: CategoryDetailView(),
            arguments: args);
        break;
      case ProductDetailView.routeName:
        return _getPageRoute(
            routeName: settings.name,
            viewToShow: ProductDetailView(),
            arguments: args);
        break;
      case CartView.routeName:
        return _getPageRoute(routeName: settings.name, viewToShow: CartView());
        break;
      case CategoriesView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: CategoriesView());
        break;
      case CheckoutView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: CheckoutView());
        break;
      case CheckoutDoneView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: CheckoutDoneView());
        break;
      case HelpView.routeName:
        return _getPageRoute(routeName: settings.name, viewToShow: HelpView());
        break;
      case LanguagesView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: LanguagesView());
        break;
      case OnBoardingView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: OnBoardingView());
        break;
      case SignInView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: SignInView());
        break;
      case SignUpView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: SignUpView());
        break;
      case ResetPasswordView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: ResetPasswordView());
        break;
      case TabsView.routeName:
        return _getPageRoute(
            routeName: settings.name, viewToShow: TabsView(), arguments: args);
        break;
      default:
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

  static PageRoute _getPageRoute(
      {String routeName, Widget viewToShow, Object arguments}) {
    return Platform.isIOS
        ? CupertinoPageRoute(
            settings: RouteSettings(name: routeName, arguments: arguments),
            builder: (_) => viewToShow)
        : MaterialPageRoute(
            settings: RouteSettings(name: routeName, arguments: arguments),
            builder: (_) => viewToShow);
  }
}
