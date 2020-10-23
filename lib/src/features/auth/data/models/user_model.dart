import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserModel extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String avatar;
  final String phoneNumber;
  final DateTime dayOfBirth;
  final bool introSeen;

  const UserModel({
    @required this.uid,
    this.name,
    this.email,
    this.avatar,
    this.phoneNumber,
    this.dayOfBirth,
    this.introSeen,
  }) : assert(uid != null);

  factory UserModel.fromMap(String id, Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    return UserModel(
      uid: id,
      name: data[UserFields.name] as String ?? '',
      email: data[UserFields.email] as String ?? '',
      avatar: data[UserFields.avatar] as String ?? '',
      phoneNumber: data[UserFields.phoneNumber] as String ?? '',
      dayOfBirth: data[UserFields.dayOfBirth] as DateTime,
      introSeen: data[UserFields.introSeen] as bool ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data[UserFields.name] = uid;
    data[UserFields.email] = email;
    data[UserFields.avatar] = avatar;
    data[UserFields.phoneNumber] = phoneNumber;
    data[UserFields.dayOfBirth] = dayOfBirth;
    data[UserFields.introSeen] = introSeen;
    return data;
  }

  factory UserModel.fromFirebaseUser(
      {User user, AdditionalUserInfo additionalData}) {
    if (user == null) {
      return null;
    }
    var email;
    if (additionalData != null) {
      if (user.email == null && additionalData?.profile['email'] != null) {
        email = additionalData?.profile['email'];
      } else {
        email = user.email;
      }
    } else {
      email = user?.email;
    }
    return UserModel(
      uid: user.uid,
      email: email,
      name: user.displayName,
      avatar: user.photoURL,
      phoneNumber: user.phoneNumber,
      introSeen: false,
    );
  }

  @override
  List<Object> get props => [
        uid,
        name,
        email,
        avatar,
        phoneNumber,
        dayOfBirth,
        introSeen,
      ];

  @override
  bool get stringify => true;
}

class UserFields {
  static const String uid = 'uid';
  static const String name = 'name';
  static const String email = 'email';
  static const String avatar = 'avatar';
  static const String introSeen = 'intro_seen';
  static const String dayOfBirth = 'dayOfBirth';
  static const String phoneNumber = 'phoneNumber';
}
