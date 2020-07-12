import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class User {
  final String uid;
  final String name;
  final String email;
  final String avatar;
  final String phoneNumber;

  const User({@required this.uid, this.name, this.email, this.avatar, this.phoneNumber});

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      email: data['email'],
      name: data['name'],
      avatar: data['photoUrl'],
      phoneNumber: data['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'email': email, 'name': name, 'avatar': avatar, 'phoneNumber': phoneNumber};
}
