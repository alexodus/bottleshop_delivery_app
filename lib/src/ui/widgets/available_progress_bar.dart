import 'package:flutter/material.dart';

class AvailableProgressBar extends StatelessWidget {
  final double available;

  const AvailableProgressBar({
    Key key,
    @required this.available,
  })  : assert(available != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 4,
          decoration: BoxDecoration(color: Theme.of(context).focusColor, borderRadius: BorderRadius.circular(6)),
        ),
        Container(
          width: available,
          height: 4,
          decoration: BoxDecoration(
              color: available > 30 ? Theme.of(context).accentColor : Colors.deepOrange,
              borderRadius: BorderRadius.circular(6)),
        ),
      ],
    );
  }
}
