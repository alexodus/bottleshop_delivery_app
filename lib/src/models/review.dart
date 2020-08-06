import 'dart:math';

import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;

class Review {
  String id = UniqueKey().toString();
  User user;
  String review;
  double rate;
  DateTime dateTime =
      DateTime.now().subtract(Duration(days: Random().nextInt(20)));

  Review(this.user, this.review, this.rate);

  String getDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}
