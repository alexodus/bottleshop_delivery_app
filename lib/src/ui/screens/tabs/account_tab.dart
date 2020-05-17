import 'package:bottleshopdeliveryapp/src/core/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/core/enums/enums.dart';
import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/help/help.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/languages/languages.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/orders/orders.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/tabs_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/ProfileSettingsDialog.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/SearchBarWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AccountTab extends StatefulWidget {
  static const String routeName = '/account';
  @override
  _AccountTabState createState() => _AccountTabState();

  AccountTab({Key key}) : super(key: key);
}

class _AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        user.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                SizedBox(
                  width: 55,
                  height: 55,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(300),
                    onTap: () {
                      Navigator.pushNamed(context, TabsScreen.routeName,
                          arguments:
                              Routes.onTabSelection(TabIndex.notifications));
                    },
                    child: ProfileAvatar(),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.15),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    onPressed: () {
                      Navigator.pushNamed(context, TabsScreen.routeName,
                          arguments:
                              Routes.onTabSelection(TabIndex.notifications));
                    },
                    child: Column(
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.bell),
                        Text(
                          'Notifications',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    onPressed: () {
                      Navigator.pushNamed(context, TabsScreen.routeName,
                          arguments: Routes.onTabSelection(TabIndex.home));
                    },
                    child: Column(
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.heart),
                        Text(
                          'Wish List',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.15),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.inbox),
                  title: Text(
                    'My Orders',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  trailing: ButtonTheme(
                    padding: EdgeInsets.all(0),
                    minWidth: 50.0,
                    height: 25.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, OrdersScreen.routeName);
                      },
                      child: Text(
                        "View all",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, OrdersScreen.routeName);
                  },
                  dense: true,
                  title: Text(
                    'Unpaid',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Chip(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.transparent,
                    shape: StadiumBorder(
                        side: BorderSide(color: Theme.of(context).focusColor)),
                    label: Text(
                      '1',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, OrdersScreen.routeName);
                  },
                  dense: true,
                  title: Text(
                    'To be shipped',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Chip(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.transparent,
                    shape: StadiumBorder(
                        side: BorderSide(color: Theme.of(context).focusColor)),
                    label: Text(
                      '5',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, OrdersScreen.routeName);
                    ;
                  },
                  dense: true,
                  title: Text(
                    'Shipped',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Chip(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    backgroundColor: Colors.transparent,
                    shape: StadiumBorder(
                        side: BorderSide(color: Theme.of(context).focusColor)),
                    label: Text(
                      '3',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, OrdersScreen.routeName);
                  },
                  dense: true,
                  title: Text(
                    'In dispute',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.15),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.user),
                  title: Text(
                    'Profile Settings',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  trailing: ButtonTheme(
                    padding: EdgeInsets.all(0),
                    minWidth: 50.0,
                    height: 25.0,
                    child: ProfileSettingsDialog(
                      user: user,
                      onChanged: () {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    'Full name',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Text(
                    user.name,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    'Email',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Text(
                    user.email,
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Text(
                    'Birth Date',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Text(
                    'TODO',
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.15),
                    offset: Offset(0, 3),
                    blurRadius: 10)
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.cog),
                  title: Text(
                    'Account Settings',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  dense: true,
                  title: Row(
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.dolly,
                        size: 22,
                        color: Theme.of(context).focusColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Shipping Adresses',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, LanguagesScreen.routeName);
                  },
                  dense: true,
                  title: Row(
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.sun,
                        size: 22,
                        color: Theme.of(context).focusColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Languages',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  trailing: Text(
                    'English',
                    style: TextStyle(color: Theme.of(context).focusColor),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, HelpScreen.routeName);
                  },
                  dense: true,
                  title: Row(
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.info,
                        size: 22,
                        color: Theme.of(context).focusColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Help & Support',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
