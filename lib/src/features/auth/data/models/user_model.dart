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
  final DateTime lastLoggedIn;
  final DateTime registrationDate;
  final bool introSeen;

  const UserModel({
    @required this.uid,
    this.name,
    this.email,
    this.avatar,
    this.phoneNumber,
    this.dayOfBirth,
    this.lastLoggedIn,
    this.registrationDate,
    this.introSeen,
  }) : assert(uid != null);

  UserModel.fromMap(String id, Map<String, dynamic> data)
      : uid = id,
        name = data[UserFields.name] as String ?? '',
        email = data[UserFields.email] as String ?? '',
        avatar = data[UserFields.avatar] as String ?? '',
        phoneNumber = data[UserFields.phoneNumber] as String ?? '',
        dayOfBirth = data[UserFields.dayOfBirth]?.toDate() as DateTime,
        lastLoggedIn = data[UserFields.lastLoggedIn]?.toDate() as DateTime,
        registrationDate =
            data[UserFields.registrationDate]?.toDate() as DateTime,
        introSeen = data[UserFields.introSeen] as bool ?? false;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data[UserFields.uid] = uid;
    data[UserFields.name] = name;
    data[UserFields.email] = email;
    data[UserFields.avatar] = avatar;
    data[UserFields.phoneNumber] = phoneNumber;
    data[UserFields.dayOfBirth] = dayOfBirth;
    data[UserFields.lastLoggedIn] = lastLoggedIn;
    data[UserFields.registrationDate] = registrationDate;
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
      registrationDate: DateTime.now().toUtc(),
      lastLoggedIn: DateTime.now().toUtc(),
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
  static const String introSeen = 'introSeen';
  static const String dayOfBirth = 'dayOfBirth';
  static const String lastLoggedIn = "last_logged_in";
  static const String registrationDate = "registration_date";
  static const String phoneNumber = 'phoneNumber';
}
