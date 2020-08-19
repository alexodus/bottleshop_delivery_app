import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/app_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/filter_drawer.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/shopping_cart_button.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/category_list_model.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/tabs_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsView extends StatelessWidget {
  static const String routeName = '/tabs';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<dynamic> routeArguments;

  TabsView({
    Key key,
    this.routeArguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteArgument args = ModalRoute.of(context).settings.arguments ??
        Routes.onTabSelection(TabIndex.home);
    return ChangeNotifierProxyProvider<CategoryListModel, TabsViewModel>(
      create: (_) => TabsViewModel(context.read, args),
      update: (context, categoryListModel, tabsViewModel) {
        return tabsViewModel.updateCategoryListModel(categoryListModel);
      },
      builder: (context, widget) {
        return AppScaffold(
          scaffoldKey: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Theme.of(context).hintColor),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              context.select((TabsViewModel viewModel) => viewModel.title),
              style: Theme.of(context).textTheme.headline4,
            ),
            actions: <Widget>[
              ShoppingCartButton(
                iconColor: Theme.of(context).hintColor,
                labelColor: Theme.of(context).accentColor,
              ),
            ],
          ),
          endDrawer: FilterDrawer(),
          body: context.select((TabsViewModel viewModel) => viewModel.tab),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).accentColor,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            iconSize: 22,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(size: 25),
            unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
            currentIndex:
                context.select((TabsViewModel viewModel) => viewModel.id),
            onTap: (i) {
              context.read<TabsViewModel>().selectTab(i);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                title: Container(height: 0.0),
              ),
              BottomNavigationBarItem(
                  title: Container(height: 5.0),
                  icon: Container(
                    alignment: Alignment.center,
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                            blurRadius: 40,
                            offset: Offset(0, 15)),
                        BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                          blurRadius: 13,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child:
                        Icon(Icons.home, color: Theme.of(context).primaryColor),
                  )),
              BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions),
                title: Container(height: 0.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
