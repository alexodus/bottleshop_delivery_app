import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsViewModel extends BaseViewModel {
  User _currentUser;
  String _selectedCategoryId;
  List<String> _selectedSubCategoryIds = [];
  String _currentTabTitle;
  int _currentTabId;
  Widget _currentTab;
  List<Category> _categories;
  final OrderTabIndex _initialOrderTabIndex;

  TabsViewModel(Locator locator, RouteArgument args)
      : _currentTab = args.argumentsList[0],
        _currentTabId = args.id,
        _initialOrderTabIndex = args.argumentsList.length > 1
            ? args.argumentsList[1] ?? OrderTabIndex.all
            : OrderTabIndex.all,
        _currentTabTitle = args.title,
        super(locator: locator) {
    locator<Authentication>()
        .currentUser()
        .then((value) => _currentUser = value);
  }

  OrderTabIndex get initialOrderTabIndex => _initialOrderTabIndex;

  String get selectedCategory => _selectedCategoryId;

  List<String> get selectedSubCategories => _selectedSubCategoryIds;

  User get currentUser => _currentUser;

  String get title => _currentTabTitle;

  int get id => _currentTabId;

  Widget get tab => _currentTab;

  List<Category> get allCategories => _categories;

  bool isCategorySelected(String id) => _selectedCategoryId == id;

  bool isSubcategorySelected(String id) => _selectedSubCategoryIds.contains(id);

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

  void selectCategory(String id) {
    _selectedCategoryId = id;
    _selectedSubCategoryIds = [];
    notifyListeners();
  }

  void selectSubCategory(String id) {
    _selectedSubCategoryIds.add(id);
    notifyListeners();
  }

  void clearSelectedCategories() {
    _selectedCategoryId = null;
    _selectedSubCategoryIds = [];
    notifyListeners();
  }

  List<SubCategory> getSubCategories(String parentCategoryId) {
    return _categories
        .firstWhere((element) => element.documentID == parentCategoryId)
        .subCategories;
  }

  Future<void> signOut() async {
    setLoading();
    await locator<Authentication>().signOut();
    setNotLoading();
  }
}
