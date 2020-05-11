import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

const defaultAvatar = 'assets/images/avatar.png';

@immutable
class User {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String phoneNumber;

  User.from(FirebaseUser firebaseUser)
      : id = firebaseUser.uid,
        name = firebaseUser.displayName,
        email = firebaseUser.email,
        avatar = firebaseUser?.photoUrl == null
            ? defaultAvatar
            : firebaseUser?.photoUrl,
        phoneNumber = firebaseUser?.phoneNumber;

  factory User.withDetails(
      {@required FirebaseUser user,
      @required String address,
      @required DateTime dateOfBirth}) {
    return UserDetails.from(user, address, dateOfBirth);
  }

  User.basic(String name, String avatar)
      : id = UniqueKey().toString(),
        name = name,
        email = '',
        avatar = avatar,
        phoneNumber = '';
}

class UserDetails extends User {
  final DateTime dateOfBirth;
  final String address;

  UserDetails.from(FirebaseUser user, this.address, this.dateOfBirth)
      : super.from(user);
}
