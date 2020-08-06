import 'dart:ui';

import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  final IconData leading;
  final String title;
  final TextStyle titleStyle;
  final VoidCallback handler;
  final Widget trailing;
  final bool dense;

  const SideMenuItem({
    Key key,
    this.leading,
    this.title,
    this.titleStyle,
    this.trailing,
    this.handler,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: dense,
      enabled: handler != null,
      onTap: () => handler(),
      leading: leading != null
          ? Icon(
              leading,
              color: Theme.of(context).focusColor.withOpacity(1),
            )
          : null,
      title: Text(
        title,
        style: titleStyle ?? Theme.of(context).textTheme.subtitle1,
      ),
      trailing: trailing,
    );
  }
}
