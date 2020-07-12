import 'package:bottleshopdeliveryapp/src/core/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/core/enums/enums.dart';
import 'package:bottleshopdeliveryapp/src/core/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsScreenViewModel extends ChangeNotifier {
  TabsScreenViewModel(this.locator, this.args)
      : _currentTab = args.argumentsList[0],
        _currentTabId = args.id,
        _currentTabTitle = args.title;

  final RouteArgument args;
  final Locator locator;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _setNotLoading() {
    _isLoading = false;
    notifyListeners();
  }

  String _currentTabTitle;
  int _currentTabId;
  Widget _currentTab;

  void selectTab(int index) {
    TabIndex newTab = TabIndex.values[index];
    var routeArg = Routes.onTabSelection(newTab);
    _currentTabId = routeArg.id;
    _currentTabTitle = routeArg.title;
    _currentTab = routeArg.argumentsList[0];
    notifyListeners();
  }

  String get title => _currentTabTitle;
  int get id => _currentTabId;
  Widget get tab => _currentTab;

  Future<void> signOut() async {
    _setLoading();
    await locator<Authentication>().signOut();
    _setNotLoading();
  }
}
