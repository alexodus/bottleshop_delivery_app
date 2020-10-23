import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/res/routes.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/products_tab.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class HomePageViewModel extends ChangeNotifier {
  Logger _logger;
  String _currentTabTitle;
  int _currentTabId;
  Widget _currentTab;

  HomePageViewModel()
      : _currentTab = ProductsTab(),
        _currentTabId = TabIndex.products.index,
        _currentTabTitle = 'Home' {
    _logger = createLogger(this.runtimeType.toString());
  }

  OrderTabIndex get initialOrderTabIndex => OrderTabIndex.all;

  String get title => _currentTabTitle;

  int get id => _currentTabId;

  Widget get tab => _currentTab;

  void selectTab(int index) {
    if (index != _currentTabId) {
      var newTab = TabIndex.values[index];
      var routeArg = AppRoutes.onTabSelection(newTab);
      _currentTabId = routeArg.id;
      _currentTabTitle = routeArg.title;
      _currentTab = routeArg.argumentsList[0];

      notifyListeners();
    }
  }
}
