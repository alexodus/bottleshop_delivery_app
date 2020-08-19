import 'package:flutter/material.dart';

@immutable
class Category {
  final String documentID;
  final String name;
  final String localizedName;
  final String icon;
  final List<SubCategory> subCategories;

  const Category._({
    @required this.documentID,
    @required this.name,
    @required this.localizedName,
    @required this.icon,
    this.subCategories,
  })  : assert(documentID != null),
        assert(name != null),
        assert(localizedName != null),
        assert(icon != null);

  factory Category.fromMap(Map<String, dynamic> data, String documentID) {
    List<SubCategory> subCategories;
    if (data['subCategories'] != null) {
      var subCategoriesData = data['subCategories'] as List<dynamic>;
      subCategories = <SubCategory>[];
      subCategoriesData.forEach((data) =>
          subCategories.add(SubCategory.fromMap(subCategories.length, data)));
    }
    return Category._(
      documentID: documentID,
      name: data['name'] as String,
      localizedName: data['localizedName'],
      icon: data['icon'],
      subCategories: subCategories,
    );
  }

  @override
  int get hashCode =>
      documentID.hashCode ^
      name.hashCode ^
      localizedName.hashCode ^
      icon.hashCode ^
      subCategories?.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          documentID == other.documentID &&
          name == other.name &&
          localizedName == other.localizedName &&
          icon == other.icon &&
          subCategories == other.subCategories;

  @override
  String toString() {
    return 'Category{documentID: $documentID, name: $name, localizedName: $localizedName, icon: $icon, subCategories: $subCategories}';
  }
}

@immutable
class SubCategory {
  final int id;
  final String name;
  final String localizedName;
  final List<SubCategory> subCategories;

  const SubCategory._({
    @required this.id,
    @required this.name,
    @required this.localizedName,
    this.subCategories,
  })  : assert(id != null),
        assert(name != null),
        assert(localizedName != null);

  factory SubCategory.fromMap(int id, Map<String, dynamic> data) {
    final subCategories = <SubCategory>[];
    if (data['subCategories'] != null) {
      var subCategoriesData = data['subCategories'] as List<dynamic>;
      subCategoriesData.forEach((data) =>
          subCategories.add(SubCategory.fromMap(subCategories.length, data)));
    }
    return SubCategory._(
      id: id,
      name: data['name'],
      localizedName: data['localizedName'],
      subCategories: subCategories,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCategory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          localizedName == other.localizedName &&
          subCategories == other.subCategories;

  @override
  String toString() {
    return 'SubCategory{id: $id, name: $name, localizedName: $localizedName, subCategories: $subCategories}';
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      localizedName.hashCode ^
      subCategories?.hashCode;
}
