import 'package:flutter/material.dart';

@immutable
class Category {
  final String documentID;
  final String name;
  final String localizedName;
  final String icon;
  final List<SubCategory> subCategories;

  const Category._({@required this.documentID, this.name, this.localizedName, this.icon, this.subCategories});

  factory Category.fromMap(Map<String, dynamic> data, String documentID) {
    return Category._(
        documentID: documentID,
        name: data['name'],
        localizedName: data['localizedName'],
        icon: data['icon'],
        subCategories: data['subCategories']);
  }
}

class SubCategory {
  final String documentID;
  final String name;
  final String localizedName;
  SubCategory(this.documentID, {this.name, this.localizedName});
}
