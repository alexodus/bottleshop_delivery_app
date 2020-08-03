import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        leading: FaIcon(
          FontAwesomeIcons.bullhorn,
          color: Theme.of(context).hintColor,
        ),
        title: Text(
          'Flash Sales',
          style: Theme.of(context).textTheme.headline4,
        ),
        trailing: Text('End in'),
      ),
    );
  }
}
