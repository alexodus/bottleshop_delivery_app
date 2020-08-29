import 'package:flutter/material.dart';

@immutable
class UserModel {
  static const String nameField = 'name';
  static const String addressField = 'address';
  static const String phoneNumberField = 'phoneNumber';

  final String name;
  final String address;
  final String phoneNumber;

  UserModel({
    @required this.name,
    @required this.address,
    @required this.phoneNumber,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json[nameField],
        address = json[addressField],
        phoneNumber = json[phoneNumberField];

  @override
  bool operator ==(other) =>
      other is UserModel &&
      other.name == name &&
      other.address == address &&
      other.phoneNumber == phoneNumber;

  @override
  int get hashCode => name.hashCode ^ address.hashCode ^ phoneNumber.hashCode;
}
