import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  final IconData leading;
  final String title;
  final VoidCallback handler;
  final Widget trailing;
  final bool dense;

  const SideMenuItem({
    Key key,
    this.leading,
    this.title,
    this.trailing,
    this.dense = false,
    this.handler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: dense,
      onTap: () => this.handler,
      leading: leading != null
          ? Icon(
              leading,
              color: Theme.of(context).focusColor.withOpacity(1),
            )
          : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      trailing: trailing,
    );
  }
}
