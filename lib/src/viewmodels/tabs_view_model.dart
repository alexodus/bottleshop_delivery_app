import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/services/notifications/push_notification_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/category_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsViewModel extends BaseViewModel {
  final _logger = Analytics.getLogger('TabsViewModel');
  User _currentUser;
  String _currentTabTitle;
  int _currentTabId;
  Widget _currentTab;
  final OrderTabIndex _initialOrderTabIndex;
  CategoryListModel _listModel;

  TabsViewModel(Locator locator, RouteArgument args)
      : _currentTab = args.argumentsList[0],
        _currentTabId = args.id,
        _initialOrderTabIndex = args.argumentsList.length > 1
            ? args.argumentsList[1] ?? OrderTabIndex.all
            : OrderTabIndex.all,
        _currentTabTitle = args.title,
        _listModel = CategoryListModel(),
        super(locator: locator) {
    init()
        .then((value) => _logger.d('data fetched'))
        .catchError((error) => _logger.e('data fetch failed: $error'));
  }

  Future<void> init() async {
    setLoading();
    try {
      _currentUser = await locator<Authentication>().currentUser();
      await Future.wait<void>(
        [
          locator<PushNotificationService>().initialise(),
          _listModel.fetchAllCategories(),
        ],
      );
      _logger.d('init OK');
    } catch (e) {
      _logger.e('failed fetching data: $e');
    } finally {
      setNotLoading();
    }
  }

  OrderTabIndex get initialOrderTabIndex => _initialOrderTabIndex;

  User get currentUser => _currentUser;

  String get title => _currentTabTitle;

  int get id => _currentTabId;

  Widget get tab => _currentTab;

  TabsViewModel updateCategoryListModel(CategoryListModel listModel) {
    setLoading();
    _listModel = listModel.instance;
    setNotLoading();
    return this;
  }

  void selectTab(int index) {
    if (index != _currentTabId) {
      var newTab = TabIndex.values[index];
      var routeArg = Routes.onTabSelection(newTab);
      _currentTabId = routeArg.id;
      _currentTabTitle = routeArg.title;
      _currentTab = routeArg.argumentsList[0];
      locator<Analytics>()
          .setCurrentScreen('${TabsView.routeName}/tab$_currentTabTitle');
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    setLoading();
    await locator<Authentication>().signOut();
    setNotLoading();
  }
}
