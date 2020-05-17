import 'package:bottleshopdeliveryapp/src/core/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/core/enums/enums.dart';
import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/category_detail/category.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/help/help.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/languages/languages.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/orders/orders.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/sign_in/sign_in_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/tabs_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<Authentication>(context, listen: false);
    var user = Provider.of<User>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, TabsScreen.routeName,
                  arguments: Routes.onTabSelection(TabIndex.account));
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1),
//              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
              ),
              accountName: Text(
                user?.name ?? '',
                style: Theme.of(context).textTheme.title,
              ),
              accountEmail: Text(
                user.email,
                style: Theme.of(context).textTheme.caption,
              ),
              currentAccountPicture: ProfileAvatar(),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, TabsScreen.routeName,
                  arguments: Routes.onTabSelection(TabIndex.home));
            },
            leading: Icon(
              Icons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Home",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, TabsScreen.routeName,
                  arguments: Routes.onTabSelection(TabIndex.notifications));
            },
            leading: FaIcon(
              FontAwesomeIcons.bell,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Notifications",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, OrdersScreen.routeName,
                  arguments: 0);
            },
            leading: FaIcon(
              FontAwesomeIcons.inbox,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "My Orders",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            trailing: Chip(
              padding: EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).focusColor)),
              label: Text(
                '8',
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, TabsScreen.routeName,
                  arguments: Routes.onTabSelection(TabIndex.favorites));
            },
            leading: FaIcon(
              FontAwesomeIcons.heart,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Wish List",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Products",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, CategoryDetailScreen.routeName);
            },
            leading: FaIcon(
              FontAwesomeIcons.inbox,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Categories",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Application Preferences",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, HelpScreen.routeName);
            },
            leading: Icon(
              FontAwesomeIcons.info,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Help & Support",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, TabsScreen.routeName,
                  arguments: Routes.onTabSelection(TabIndex.account));
            },
            leading: FaIcon(
              FontAwesomeIcons.cog,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Settings",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, LanguagesScreen.routeName);
            },
            leading: FaIcon(
              FontAwesomeIcons.sun,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Languages",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () async {
              await authService.signOut();
              return Navigator.of(context).pushNamedAndRemoveUntil(
                  SignInScreen.routeName, ModalRoute.withName('/'));
            },
            leading: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Log out",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Version 0.0.1",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
