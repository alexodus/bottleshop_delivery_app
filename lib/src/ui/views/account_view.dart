import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/app_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/profile_avatar_widget.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/profile_settings_dialog.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import 'help_view.dart';
import 'languages_view.dart';

class AccountView extends HookWidget {
  static const String routeName = '/account';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldKey: GlobalKey<ScaffoldState>(),
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
        child: useProvider(userDetailsProvider).when(
          data: (value) => Column(
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              value.name,
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              value.email,
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
                          child: ProfileAvatar(imageUrl: value.avatar),
                        ),
                      )
                    ],
                  )),
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
                            TabsView.routeName,
                            arguments: Routes.onTabSelection(TabIndex.orders),
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
                        TabsView.routeName,
                        arguments: Routes.onTabSelection(
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
                            side: BorderSide(
                                color: Theme.of(context).focusColor)),
                        label: Text(
                          '1',
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => Navigator.pushNamed(
                        context,
                        TabsView.routeName,
                        arguments: Routes.onTabSelection(
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
                            side: BorderSide(
                                color: Theme.of(context).focusColor)),
                        label: Text(
                          '5',
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => Navigator.pushReplacementNamed(
                        context,
                        TabsView.routeName,
                        arguments: Routes.onTabSelection(
                            TabIndex.orders, OrderTabIndex.inDispute),
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
                            side: BorderSide(
                                color: Theme.of(context).focusColor)),
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
                        child: ProfileSettingsDialog(
                          user: value,
                          onChanged: (User user) {},
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
                        value.name,
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
                        value.email,
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
                        Navigator.pushNamed(context, LanguagesView.routeName);
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
                        Navigator.pushNamed(context, HelpView.routeName);
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
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          error: null, // TODO: crate proper error message
        ),
      ),
    );
  }
}
