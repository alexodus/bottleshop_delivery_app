import 'package:bottleshopdeliveryapp/src/core/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/core/enums/enums.dart';
import 'package:bottleshopdeliveryapp/src/core/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/screens/tabs_screen_view_model.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/DrawerWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/FilterWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/ShoppingCartButtonWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  static const String routeName = '/tabs';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TabsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteArgument args = ModalRoute.of(context).settings.arguments ?? Routes.onTabSelection(TabIndex.home);
    return ChangeNotifierProvider<TabsScreenViewModel>(
      create: (_) => TabsScreenViewModel(context.read, args),
      builder: (context, child) {
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
              context.select((TabsScreenViewModel viewModel) => viewModel.title),
              style: Theme.of(context).textTheme.headline4,
            ),
            actions: <Widget>[
              ShoppingCartButtonWidget(
                  iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
              Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(300),
                    onTap: () {
                      Navigator.pushNamed(context, TabsScreen.routeName,
                          arguments: Routes.onTabSelection(TabIndex.account));
                    },
                    child: ProfileAvatar(),
                  )),
            ],
          ),
          body: context.select((TabsScreenViewModel viewModel) => viewModel.tab),
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
            currentIndex: context.select((TabsScreenViewModel viewModel) => viewModel.id),
            onTap: (i) {
              context.read<TabsScreenViewModel>().selectTab(i);
            },
            items: [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bell),
                title: Container(height: 0.0),
              ),
              BottomNavigationBarItem(title: Container(height: 0.0), icon: FaIcon(FontAwesomeIcons.user)),
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
                            color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
                      ],
                    ),
                    child: Icon(Icons.home, color: Theme.of(context).primaryColor),
                  )),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.heart),
                title: Container(height: 0.0),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.inbox),
                title: Container(height: 0.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
