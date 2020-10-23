import 'package:bottleshopdeliveryapp/src/core/data/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/fatal_error.dart';
import 'package:bottleshopdeliveryapp/src/features/account/presentation/pages/account_page.dart';
import 'package:bottleshopdeliveryapp/src/features/account/presentation/pages/languages_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/pages/sign_in_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/pages/splash.dart';
import 'package:bottleshopdeliveryapp/src/features/cart/presentation/pages/cart_page.dart';
import 'package:bottleshopdeliveryapp/src/features/checkout/presentation/pages/checkout_done_page.dart';
import 'package:bottleshopdeliveryapp/src/features/checkout/presentation/pages/checkout_page.dart';
import 'package:bottleshopdeliveryapp/src/features/help/presentation/pages/help_page.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/favorites_tab.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/home_page.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/orders_tab.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/products_tab.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/pages/categories_page.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/pages/category_detail_page.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/pages/product_detail_page.dart';
import 'package:bottleshopdeliveryapp/src/features/tutorial/presentation/pages/tutorial_page.dart';
import 'package:flutter/material.dart';

enum TabIndex { favorites, products, orders }
enum OrderTabIndex { all, shipped, toBeShipped, inDispute }

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AccountPage.routeName:
        return _getPageRoute(settings: settings, viewToShow: AccountPage());
        break;
      case CategoryDetailPage.routeName:
        return _getPageRoute(
            settings: settings, viewToShow: CategoryDetailPage());
        break;
      case ProductDetailPage.routeName:
        return _getPageRoute(
            settings: settings, viewToShow: ProductDetailPage());
        break;
      case CartPage.routeName:
        return _getPageRoute(settings: settings, viewToShow: CartPage());
        break;
      case CategoriesPage.routeName:
        return _getPageRoute(settings: settings, viewToShow: CategoriesPage());
        break;
      case CheckoutPage.routeName:
        return _getPageRoute(settings: settings, viewToShow: CheckoutPage());
        break;
      case CheckoutDonePage.routeName:
        return _getPageRoute(
            settings: settings, viewToShow: CheckoutDonePage());
        break;
      case HelpPage.routeName:
        return _getPageRoute(settings: settings, viewToShow: HelpPage());
        break;
      case LanguagesPage.routeName:
        return _getPageRoute(settings: settings, viewToShow: LanguagesPage());
        break;
      case TutorialPage.routeName:
        return _getPageRoute(settings: settings, viewToShow: TutorialPage());
        break;
      case SignInPage.routeName:
        return _getPageRoute(settings: settings, viewToShow: SignInPage());
        break;
      case SignUpPage.routeName:
        return _getPageRoute(settings: settings, viewToShow: SignUpPage());
        break;
      case ResetPasswordPage.routeName:
        return _getPageRoute(
            settings: settings, viewToShow: ResetPasswordPage());
        break;
      case HomePage.routeName:
        return _getPageRoute(settings: settings, viewToShow: HomePage());
        break;
      case Splash.routeName:
        return _getPageRoute(settings: settings, viewToShow: Splash());
        break;
      default:
        return MaterialPageRoute(builder: (context) {
          return FatalError(errorMessage: settings.name);
        });
    }
  }

  static PageRoute _getPageRoute(
      {RouteSettings settings, Widget viewToShow, fullScreen = false}) {
    return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (_) => viewToShow,
        fullscreenDialog: fullScreen);
  }

  static final tabs = <TabIndex, Widget>{
    TabIndex.favorites: FavoritesTab(), //0
    TabIndex.products: ProductsTab(), // 1
    TabIndex.orders: OrdersTab() // 2
  };

  static RouteArgument onTabSelection(TabIndex tab, [dynamic args]) {
    switch (tab) {
      case TabIndex.products:
        return RouteArgument(
            title: 'Products',
            id: TabIndex.products.index,
            argumentsList: [ProductsTab()]);
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
            title: 'Home',
            id: TabIndex.products.index,
            argumentsList: [ProductsTab()]);
    }
  }
}
