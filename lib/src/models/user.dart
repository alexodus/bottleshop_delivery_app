import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';

@immutable
class User {
  final String uid;
  final String name;
  final String email;
  final String avatar;
  final String phoneNumber;
  final DateTime dayOfBirth;

  const User({
    @required this.uid,
    this.name,
    this.email,
    this.avatar,
    this.phoneNumber,
    this.dayOfBirth,
  }) : assert(uid != null);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatar: map['avatar'] as String,
      phoneNumber: map['phoneNumber'] as String,
      dayOfBirth: map['dayOfBirth'] as DateTime,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'uid': this.uid,
      'name': this.name,
      'email': this.email,
      'avatar': this.avatar,
      'phoneNumber': this.phoneNumber,
      'dayOfBirth': this.dayOfBirth,
    } as Map<String, dynamic>;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          email == other.email &&
          avatar == other.avatar &&
          phoneNumber == other.phoneNumber &&
          dayOfBirth == other.dayOfBirth;

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      avatar.hashCode ^
      phoneNumber.hashCode ^
      dayOfBirth.hashCode;

  @override
  String toString() {
    return 'User{uid: $uid, name: $name, email: $email, avatar: $avatar, phoneNumber: $phoneNumber, dayOfBirth: $dayOfBirth}';
  }

  factory User.fromFirebase(
      {@required auth.User user, auth.AdditionalUserInfo additionalData}) {
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
    }
    return User(
        uid: user.uid,
        email: email,
        name: user.displayName,
        avatar: user.photoURL,
        phoneNumber: user.phoneNumber);
  }
}

enum AddressType { shipping, billing }

@immutable
class Address {
  final String streetName;
  final String streetNumber;
  final String city;
  final String zipCode;
  final AddressType addressType;

  const Address({
    @required this.streetName,
    @required this.streetNumber,
    @required this.city,
    @required this.zipCode,
    @required this.addressType,
  })  : assert(streetName != null),
        assert(streetName != null),
        assert(streetNumber != null),
        assert(city != null),
        assert(zipCode != null),
        assert(addressType != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          streetName == other.streetName &&
          streetNumber == other.streetNumber &&
          city == other.city &&
          zipCode == other.zipCode &&
          addressType == other.addressType;

  @override
  int get hashCode =>
      streetName.hashCode ^
      streetNumber.hashCode ^
      city.hashCode ^
      zipCode.hashCode ^
      addressType.hashCode;

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      streetName: map['streetName'] as String,
      streetNumber: map['streetNumber'] as String,
      city: map['city'] as String,
      zipCode: map['zipCode'] as String,
      addressType: map['addressType'] as AddressType,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'streetName': this.streetName,
      'streetNumber': this.streetNumber,
      'city': this.city,
      'zipCode': this.zipCode,
      'addressType': this.addressType,
    } as Map<String, dynamic>;
  }

  @override
  String toString() {
    return 'Address{streetName: $streetName, streetNumber: $streetNumber, city: $city, zipCode: $zipCode, addressType: $addressType}';
  }
}
