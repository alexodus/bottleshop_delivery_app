import 'package:bottleshopdeliveryapp/src/core/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class User {
  final String uid;
  final String name;
  final String email;
  final String avatar;
  final String phoneNumber;

  User({this.uid, this.name, this.email, this.avatar, this.phoneNumber});

  factory User.fromMap(Map data) {
    return User(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      avatar: data['photoUrl'] ?? Constants.defaultAvatar,
      phoneNumber: data['phoneNumber'] ?? '',
    );
  }

  factory User.fromFirebase(FirebaseUser user) {
    return User(
        uid: user.uid,
        email: user.email,
        name: user.displayName,
        avatar: user?.photoUrl ?? Constants.defaultAvatar,
        phoneNumber: user?.phoneNumber ?? '');
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'photoUrl': avatar,
        'phoneNumber': phoneNumber
      };
}
