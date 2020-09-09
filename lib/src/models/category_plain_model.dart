import 'package:bottleshopdeliveryapp/src/models/localized_model.dart';
import 'package:flutter/material.dart';

@immutable
class CategoryPlainModel {
  static const String localizedNameField = 'localized_name';
  static const String nameField = 'name';
  static const String extraCategoryField = 'extra';

  final String id;
  final LocalizedModel localizedName;
  final String name;
  final bool isExtraCategory;

  CategoryPlainModel({
    @required this.id,
    @required this.localizedName,
    @required this.name,
    @required this.isExtraCategory,
  });

  CategoryPlainModel.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        name = json[nameField],
        localizedName = LocalizedModel.fromJson(json[localizedNameField]),
        isExtraCategory = json[extraCategoryField] ?? false;

  @override
  bool operator ==(other) =>
      other is CategoryPlainModel &&
      other.id == id &&
      other.localizedName == localizedName &&
      other.name == name &&
      other.isExtraCategory == isExtraCategory;

  @override
  int get hashCode =>
      id.hashCode ^
      localizedName.hashCode ^
      name.hashCode ^
      isExtraCategory.hashCode;

  @override
  String toString() {
    return 'CategoryPlainModel{id: $id, localizedName: $localizedName, name: $name, isExtraCategory: $isExtraCategory}';
  }
}
