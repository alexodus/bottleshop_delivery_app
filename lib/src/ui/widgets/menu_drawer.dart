import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/account_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/help_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/notifications_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/sign_in_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/side_menu_header.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/side_menu_item.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/tabs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((TabsViewModel viewModel) => viewModel.currentUser);
    final userName = currentUser?.name ?? '';
    final userEmail = currentUser?.email ?? '';
    return Drawer(
      child: ListView(
        children: <Widget>[
          SideMenuHeader(userName: userName, userEmail: userEmail),
          SideMenuItem(
            leading: Icons.home,
            title: "Home",
            handler: () => Navigator.pushReplacementNamed(
              context,
              TabsView.routeName,
              arguments: Routes.onTabSelection(TabIndex.home),
            ),
          ),
          SideMenuItem(
            leading: Icons.notifications,
            title: "Notifications",
            handler: () => Navigator.pushNamed(
              context,
              NotificationsView.routeName,
            ),
          ),
          SideMenuItem(
            dense: true,
            title: "Application Preferences",
            titleStyle: Theme.of(context).textTheme.bodyText2,
          ),
          SideMenuItem(
            leading: Icons.settings,
            handler: () => Navigator.pushNamed(context, AccountView.routeName),
            title: "Settings",
          ),
          SideMenuItem(
            handler: () => Navigator.pushNamed(context, HelpView.routeName),
            leading: Icons.help,
            title: "Help & Support",
          ),
          SideMenuItem(
            handler: () async {
              await context.read<TabsViewModel>().signOut();
              await Navigator.pushReplacementNamed(
                  context, SignInView.routeName);
            },
            leading: Icons.exit_to_app,
            title: "Log out",
          ),
          SideMenuItem(
            dense: true,
            title: "Version 0.0.1",
            titleStyle: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
