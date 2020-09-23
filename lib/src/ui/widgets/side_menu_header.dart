import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/account_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/profile_avatar_widget.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class SideMenuHeader extends HookWidget {
  const SideMenuHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AsyncValue<User> user = useProvider(userDetailsProvider);
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AccountView.routeName),
      child: user.when(
        data: (value) => UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor.withOpacity(0.4),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
          ),
          accountName: Text(
            value.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          accountEmail: Text(
            value.email,
            style: Theme.of(context).textTheme.caption,
          ),
          currentAccountPicture: ProfileAvatar(imageUrl: value.avatar),
        ),
        loading: null,
        error: null,
      ),
    );
  }
}
