import 'package:flutter/material.dart';

class FlashSalesHeader extends StatelessWidget {
  const FlashSalesHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        leading: Icon(
          Icons.announcement,
          color: Theme.of(context).hintColor,
        ),
        title: Text(
          'Flash Sales',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
