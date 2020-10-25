import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:bottleshopdeliveryapp/src/features/home/data/models/tab_item.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/favorites_tab.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/orders_tab.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/products_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class HomePageViewModel extends ChangeNotifier {
  Logger _logger;
  TabItem _currentTab = TabItem.products;
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void select(TabItem tabItem) {
    _logger.v('selecting: ${tabItem.toString()}');
    if (tabItem == _currentTab) {
      _navigatorKey.currentState?.popUntil((route) => route.isFirst);
      _logger.v('isFirst: ${_currentTab.toString()}');
    } else {
      _currentTab = tabItem;
    }
    notifyListeners();
  }

  Map<TabItem, WidgetBuilder> get _widgetBuilders {
    return {
      TabItem.favorites: (_) => FavoritesTab(),
      TabItem.products: (_) => ProductsTab(),
      TabItem.orders: (_) => OrdersTab(),
    };
  }

  HomePageViewModel() {
    _logger = createLogger(this.runtimeType.toString());
    _logger.v('created');
  }

  String get title => TabItemData.allTabs[_currentTab].title;

  int get index => TabItemData.allTabs.keys.toList().indexOf(_currentTab);

  WidgetBuilder get tabBuilder => _widgetBuilders[_currentTab];

  GlobalKey<NavigatorState> get navigator => _navigatorKey;
}
