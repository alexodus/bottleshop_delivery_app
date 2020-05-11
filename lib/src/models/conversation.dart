import 'package:bottleshopdeliveryapp/src/models/chat.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:flutter/material.dart';

class Conversation {
  String id = UniqueKey().toString();
  List<Chat> chats;
  bool read;
  User user;

  Conversation(this.user, this.chats, this.read);
}
