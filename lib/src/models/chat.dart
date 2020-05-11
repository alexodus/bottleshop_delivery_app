import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:flutter/material.dart';

class Chat {
  String id = UniqueKey().toString();
  String text;
  String time;
  User user;

  Chat(this.text, this.time, this.user);
}
