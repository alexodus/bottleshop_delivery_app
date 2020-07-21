import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' show DateFormat;

class FlashSalesHeader extends StatefulWidget {
  const FlashSalesHeader({
    Key key,
  }) : super(key: key);

  @override
  _FlashSalesHeaderState createState() => _FlashSalesHeaderState();
}

class _FlashSalesHeaderState extends State<FlashSalesHeader> {
  String _timer;
  @override
  void initState() {
    super.initState();
    _initTimer();
  }

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
        trailing: Text('End in $_timer'),
      ),
    );
  }

  void _initTimer() {
    var _now = DateTime.now();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _now = _now.subtract(Duration(seconds: 1));
          _timer = DateFormat('HH:mm:ss').format(_now);
        });
      }
    });
  }
}
