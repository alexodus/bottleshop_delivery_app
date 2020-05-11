import 'package:bottleshopdeliveryapp/src/screens/account.dart';
import 'package:bottleshopdeliveryapp/src/screens/favorites.dart';
import 'package:bottleshopdeliveryapp/src/screens/home.dart';
import 'package:bottleshopdeliveryapp/src/screens/messages.dart';
import 'package:bottleshopdeliveryapp/src/screens/shop_notifications.dart';
import 'package:bottleshopdeliveryapp/src/utils/route_generator.dart';
import 'package:bottleshopdeliveryapp/src/utils/ui_helper.dart';
import 'package:bottleshopdeliveryapp/src/widgets/DrawerWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/FilterWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabsScreen extends StatefulWidget {
  final currentTab;

  TabsScreen({
    Key key,
    this.currentTab,
  }) : super(key: key);

  @override
  _TabsScreenState createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedTab = 2;
  String currentTitle = 'Home';
  Widget currentPage = HomeScreen();
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectTab(widget.currentTab);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(TabsScreen oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      selectedTab = tabItem;
      switch (tabItem) {
        case 0:
          currentTitle = 'Notifications';
          currentPage = ShopNotificationsScreen();
          break;
        case 1:
          currentTitle = 'Account';
          currentPage = AccountScreen();
          break;
        case 2:
          currentTitle = 'Home';
          currentPage = HomeScreen();
          break;
        case 3:
          currentTitle = 'Messages';
          currentPage = MessagesScreen();
          break;
        case 4:
          currentTitle = 'Favorites';
          currentPage = FavoritesScreen();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      endDrawer: FilterWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          currentTitle,
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: <Widget>[
          ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
          Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(300),
                onTap: () {
                  Navigator.pushNamed(context, RoutePaths.tabs, arguments: 1);
                },
                child: ProfileAvatar(),
              )),
        ],
      ),
      body: currentPage,
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
        currentIndex: selectedTab,
        onTap: (i) {
          this._selectTab(i);
        },
        // this will be set when a  tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bell),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
              title: Container(height: 0.0),
              icon: FaIcon(FontAwesomeIcons.user)),
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
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 40,
                        offset: Offset(0, 15)),
                    BoxShadow(
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                        blurRadius: 13,
                        offset: Offset(0, 3))
                  ],
                ),
                child: Icon(Icons.home, color: Theme.of(context).primaryColor),
              )),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.rocketchat),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
            title: Container(height: 0.0),
          ),
        ],
      ),
    );
  }
}
