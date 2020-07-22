import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/categories_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/help_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/languages_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/orders_view.dart';
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
    final currentUser = context.select((TabsViewModel viewModel) => viewModel.currentUser);
    debugPrint('data: $currentUser');
    final userName = currentUser?.name ?? '';
    final userEmail = currentUser?.email ?? '';
    return Drawer(
      child: ListView(
        children: <Widget>[
          SideMenuHeader(userName: userName, userEmail: userEmail),
          SideMenuItem(
            leading: Icons.home,
            title: "Home",
            handler: () => Navigator.pushNamed(
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
              TabsView.routeName,
              arguments: Routes.onTabSelection(TabIndex.notifications),
            ),
          ),
          SideMenuItem(
            leading: Icons.list,
            title: "My Orders",
            handler: () => Navigator.pushNamed(context, OrdersView.routeName),
            trailing: Chip(
              padding: EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor)),
              label: Text(
                '8',
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ),
          ),
          SideMenuItem(
            leading: Icons.favorite,
            title: "Wish List",
            handler: () => Navigator.pushNamed(
              context,
              TabsView.routeName,
              arguments: Routes.onTabSelection(TabIndex.favorites),
            ),
          ),
          SideMenuItem(
            leading: Icons.remove,
            title: "Products",
            dense: true,
          ),
          SideMenuItem(
            leading: Icons.category,
            title: "Categories",
            handler: () => Navigator.pushNamed(context, CategoriesView.routeName),
          ),
          SideMenuItem(
            dense: true,
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
            title: "Application Preferences",
          ),
          SideMenuItem(
            handler: () => Navigator.pushNamed(context, HelpView.routeName),
            leading: Icons.help,
            title: "Help & Support",
          ),
          SideMenuItem(
            leading: Icons.settings,
            handler: () => Navigator.pushNamed(
              context,
              TabsView.routeName,
              arguments: Routes.onTabSelection(TabIndex.account),
            ),
            title: "Settings",
          ),
          SideMenuItem(
              handler: () => Navigator.pushNamed(context, LanguagesView.routeName),
              leading: Icons.language,
              title: "Languages"),
          SideMenuItem(
            handler: () async {
              await context.read<TabsViewModel>().signOut();
              await Navigator.pushReplacementNamed(context, SignInView.routeName);
            },
            leading: Icons.offline_bolt,
            title: "Log out",
          ),
          SideMenuItem(
            dense: true,
            title: "Version 0.0.1",
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
