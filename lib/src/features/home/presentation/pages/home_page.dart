import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/filter_drawer.dart';
import 'package:bottleshopdeliveryapp/src/features/cart/presentation/widgets/shopping_cart_button.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class HomePage extends HookWidget {
  static const String routeName = '/home';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabsViewModel = useProvider(homePageModelProvider);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          tabsViewModel.title,
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
      body: tabsViewModel.tab,
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BottomNavBar extends HookWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabsViewModel = useProvider(homePageModelProvider);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).accentColor,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      iconSize: 22,
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedIconTheme: IconThemeData(size: 25),
      unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
      currentIndex: tabsViewModel.id,
      onTap: (i) => context.read(homePageModelProvider).selectTab(i),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
        ),
        BottomNavigationBarItem(
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
                  color: Theme.of(context).accentColor.withOpacity(0.4),
                  blurRadius: 40,
                  offset: Offset(0, 15)),
              BoxShadow(
                color: Theme.of(context).accentColor.withOpacity(0.4),
                blurRadius: 13,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(Icons.home, color: Theme.of(context).primaryColor),
        )),
        BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions),
        ),
      ],
    );
  }
}
