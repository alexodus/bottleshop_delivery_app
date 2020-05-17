import 'package:bottleshopdeliveryapp/src/core/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/core/enums/enums.dart';
import 'package:bottleshopdeliveryapp/src/core/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/base_view_model.dart';
import 'package:flutter/cupertino.dart';

class TabsScreenViewModel extends BaseViewModel {
  String _currentTabTitle;
  int _currentTabId;
  Widget _currentTab;

  TabsScreenViewModel({BuildContext context, RouteArgument args})
      : _currentTab = args.argumentsList[0],
        _currentTabId = args.id,
        _currentTabTitle = args.title,
        super(context: context);

  void selectTabFrom(RouteArgument routeArgument) {
    selectTab(routeArgument.id);
  }

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
    loading = true;
    await authentication.signOut();
  }

  @override
  void dispose() {
    print('signUpViewModel dispose');
    super.dispose();
  }
}
