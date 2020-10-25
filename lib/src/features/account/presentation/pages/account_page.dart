import 'package:bottleshopdeliveryapp/src/core/presentation/res/routes.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/profile_avatar.dart';
import 'package:bottleshopdeliveryapp/src/features/account/presentation/pages/languages_page.dart';
import 'package:bottleshopdeliveryapp/src/features/account/presentation/widgets/profile_settings_dialog.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/help/presentation/pages/help_page.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class AccountPage extends HookWidget {
  static const String routeName = '/account';
  const AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useProvider(currentUserProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: <Widget>[
                  if (user != null) ...[
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
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                      width: 55,
                      height: 55,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(300),
                        child: ProfileAvatar(imageUrl: user.avatar),
                      ),
                    )
                  ],
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
                    leading: Icon(Icons.subscriptions),
                    title: Text(
                      'My Orders',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: ButtonTheme(
                      padding: EdgeInsets.all(0),
                      minWidth: 50.0,
                      height: 25.0,
                      child: FlatButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          HomePage.routeName,
                          arguments: AppRoutes.onTabSelection(TabIndex.orders),
                        ),
                        child: Text(
                          'View all',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      HomePage.routeName,
                      arguments: AppRoutes.onTabSelection(
                          TabIndex.orders, OrderTabIndex.toBeShipped),
                    ),
                    dense: true,
                    title: Text(
                      'To be shipped',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Theme.of(context).focusColor)),
                      label: Text(
                        '1',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.pushNamed(
                      context,
                      HomePage.routeName,
                      arguments: AppRoutes.onTabSelection(
                          TabIndex.orders, OrderTabIndex.shipped),
                    ),
                    dense: true,
                    title: Text(
                      'Shipped',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Theme.of(context).focusColor)),
                      label: Text(
                        '5',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      HomePage.routeName,
                      arguments: AppRoutes.onTabSelection(
                          TabIndex.orders, OrderTabIndex.delivered),
                    ),
                    dense: true,
                    title: Text(
                      'In dispute',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Theme.of(context).focusColor)),
                      label: Text(
                        '3',
                        style: TextStyle(color: Theme.of(context).focusColor),
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
                    leading: Icon(Icons.person_outline),
                    title: Text(
                      'Profile Settings',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: ButtonTheme(
                      padding: EdgeInsets.all(0),
                      minWidth: 50.0,
                      height: 25.0,
                      child: ProfileSettingsDialog(),
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
                    leading: Icon(Icons.settings),
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
                        Icon(
                          Icons.location_city,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Shipping Addresses',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, LanguagesPage.routeName);
                    },
                    dense: true,
                    title: Row(
                      children: <Widget>[
                        Icon(
                          Icons.language,
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
                      Navigator.pushNamed(context, HelpPage.routeName);
                    },
                    dense: true,
                    title: Row(
                      children: <Widget>[
                        Icon(
                          Icons.help_outline,
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
      ),
    );
  }
}
