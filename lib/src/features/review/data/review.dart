import 'dart:math';

import 'package:bottleshopdeliveryapp/src/features/auth/data/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;

class Review {
  String id = UniqueKey().toString();
  UserModel user;
  String review;
  double rate;
  DateTime dateTime =
      DateTime.now().subtract(Duration(days: Random().nextInt(20)));

  Review(this.user, this.review, this.rate);

  String getDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}
