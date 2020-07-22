import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class User {
  final String uid;
  final String name;
  final String email;
  final String avatar;
  final String phoneNumber;
  final List<Address> addresses;

  const User({
    @required this.uid,
    this.name,
    this.email,
    this.avatar,
    this.phoneNumber,
    this.addresses,
  }) : assert(uid != null);

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
        uid: data['uid'],
        email: data['email'],
        name: data['name'],
        avatar: data['photoUrl'],
        phoneNumber: data['phoneNumber'],
        addresses: data['addresses']);
  }

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'email': email, 'name': name, 'avatar': avatar, 'phoneNumber': phoneNumber, 'addresses': addresses};
}

@immutable
class Address {
  final String streetName;
  final String streetNumber;
  final String city;
  final String zipCode;
  final bool isBillingAddress;

  Address({this.streetName, this.streetNumber, this.city, this.zipCode, this.isBillingAddress});
}
