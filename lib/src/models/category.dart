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
  });

  factory Category.fromMap(Map<String, dynamic> data, String documentID) {
    List<SubCategory> subCategories;
    if (data['subCategories'] != null) {
      var subCategoriesData = data['subCategories'];
      subCategories = [];
      subCategoriesData
          .forEach((data) => subCategories.add(SubCategory.fromMap(data)));
    }
    return Category._(
      documentID: documentID,
      name: data['name'],
      localizedName: data['localizedName'],
      icon: data['icon'],
      subCategories: subCategories,
    );
  }
}

@immutable
class SubCategory {
  final String name;
  final String localizedName;
  final List<SubCategory> subCategories;

  const SubCategory._({
    @required this.name,
    @required this.localizedName,
    this.subCategories,
  });

  factory SubCategory.fromMap(Map<String, dynamic> data) {
    List<SubCategory> subCategories;
    if (data['subCategories'] != null) {
      var subCategoriesData = data['subCategories'];
      subCategories = [];
      subCategoriesData
          .forEach((data) => subCategories.add(SubCategory.fromMap(data)));
    }
    return SubCategory._(
      name: data['name'],
      localizedName: data['localizedName'],
      subCategories: subCategories,
    );
  }
}
