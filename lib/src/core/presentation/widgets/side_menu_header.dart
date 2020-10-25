import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/profile_avatar.dart';
import 'package:bottleshopdeliveryapp/src/features/account/presentation/pages/account_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class SideMenuHeader extends HookWidget {
  const SideMenuHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData =
        useProvider(userRepositoryProvider.select((value) => value.user));
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AccountPage.routeName),
      child: UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor.withOpacity(0.4),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
        ),
        accountName: Text(
          userData?.name ?? '',
          style: Theme.of(context).textTheme.headline6,
        ),
        accountEmail: Text(
          userData?.email ?? '',
          style: Theme.of(context).textTheme.caption,
        ),
        currentAccountPicture: ProfileAvatar(imageUrl: userData?.avatar),
      ),
    );
  }
}
