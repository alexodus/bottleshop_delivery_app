import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/side_menu_header.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/side_menu_item.dart';
import 'package:bottleshopdeliveryapp/src/features/account/presentation/pages/account_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/help/presentation/pages/help_page.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class MenuDrawer extends HookWidget {
  const MenuDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SideMenuHeader(),
          SideMenuItem(
            leading: Icons.home,
            title: 'Home',
            handler: () => Navigator.pushReplacementNamed(
              context,
              HomePage.routeName,
            ),
          ),
          SideMenuItem(
            dense: true,
            title: 'Application Preferences',
            titleStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .merge(TextStyle(color: Theme.of(context).focusColor)),
          ),
          SideMenuItem(
            leading: Icons.settings,
            handler: () => Navigator.pushNamed(context, AccountPage.routeName),
            title: 'Settings',
          ),
          SideMenuItem(
            handler: () => Navigator.pushNamed(context, HelpPage.routeName),
            leading: Icons.help,
            title: 'Help & Support',
          ),
          SideMenuItem(
            handler: () async {
              await context.read(userRepositoryProvider).signOut();
            },
            leading: Icons.exit_to_app,
            title: 'Log out',
          ),
          SideMenuItem(
            dense: true,
            title: 'Version 0.0.1',
            titleStyle: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
