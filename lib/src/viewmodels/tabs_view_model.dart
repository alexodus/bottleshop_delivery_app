import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:flutter/widgets.dart';

class TabsViewModel extends ChangeNotifier {
  String _currentTabTitle;
  int _currentTabId;
  Widget _currentTab;

  OrderTabIndex get initialOrderTabIndex => OrderTabIndex.all;

  String get title => _currentTabTitle;

  int get id => _currentTabId;

  Widget get tab => _currentTab;

  void selectTab(int index) {
    if (index != _currentTabId) {
      var newTab = TabIndex.values[index];
      var routeArg = Routes.onTabSelection(newTab);
      _currentTabId = routeArg.id;
      _currentTabTitle = routeArg.title;
      _currentTab = routeArg.argumentsList[0];
      AnalyticsService()
          .setCurrentScreen('${TabsView.routeName}/tab$_currentTabTitle');
      notifyListeners();
    }
  }
}
