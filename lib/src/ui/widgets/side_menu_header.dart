import 'package:bottleshopdeliveryapp/src/constants/routes.dart';
import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';

class SideMenuHeader extends StatelessWidget {
  final String userName;
  final String userEmail;

  const SideMenuHeader({
    Key key,
    @required this.userName,
    @required this.userEmail,
  })  : assert(userEmail != null),
        assert(userName != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, TabsView.routeName, arguments: Routes.onTabSelection(TabIndex.account));
      },
      child: UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor.withOpacity(0.1),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
        ),
        accountName: Text(
          userName,
          style: Theme.of(context).textTheme.headline6,
        ),
        accountEmail: Text(
          userEmail,
          style: Theme.of(context).textTheme.caption,
        ),
        currentAccountPicture: const ProfileAvatar(),
      ),
    );
  }
}
