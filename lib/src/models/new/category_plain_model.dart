import 'package:flutter/material.dart';

import 'localized_model.dart';

@immutable
class CategoryPlainModel {
  static const String localizedNameField = 'localized_name';
  static const String nameField = 'name';

  final String id;
  final LocalizedModel localizedName;
  final String name;

  CategoryPlainModel({
    @required this.id,
    @required this.localizedName,
    @required this.name,
  });

  CategoryPlainModel.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        name = json[nameField],
        localizedName = LocalizedModel.fromJson(json[localizedNameField]);

  @override
  bool operator ==(other) =>
      other is CategoryPlainModel &&
      other.id == id &&
      other.localizedName == localizedName &&
      other.name == name;

  @override
  int get hashCode => id.hashCode ^ localizedName.hashCode ^ name.hashCode;
}
