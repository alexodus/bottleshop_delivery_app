import 'package:bottleshopdeliveryapp/src/state/AuthState.dart';
import 'package:bottleshopdeliveryapp/src/utils/route_generator.dart';
import 'package:bottleshopdeliveryapp/src/utils/ui_helper.dart';
import 'package:bottleshopdeliveryapp/src/widgets/ProfileSettingsDialog.dart';
import 'package:bottleshopdeliveryapp/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();

  AccountScreen({Key key}) : super(key: key);
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context);
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
                        authState.user.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        authState.user.email,
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
                      Navigator.pushNamed(context, RoutePaths.tabs,
                          arguments: 0);
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
                      Navigator.pushNamed(context, RoutePaths.tabs,
                          arguments: 0);
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
                      Navigator.pushNamed(context, RoutePaths.tabs,
                          arguments: 2);
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
                        Navigator.pushNamed(context, RoutePaths.orders);
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
                    Navigator.pushNamed(context, RoutePaths.orders);
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
                    Navigator.pushNamed(context, RoutePaths.orders);
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
                    Navigator.pushNamed(context, RoutePaths.orders);
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
                    Navigator.pushNamed(context, RoutePaths.orders);
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
                      user: authState.user,
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
                    authState.user.name,
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
                    authState.user.email,
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
                    Navigator.pushNamed(context, RoutePaths.languages);
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
                    Navigator.pushNamed(context, RoutePaths.help);
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
