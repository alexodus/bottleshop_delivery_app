import 'package:bottleshopdeliveryapp/src/core/data/models/localized_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/categories_tree_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CategoryPlainModel extends Equatable {
  static const String localizedNameField = 'localized_name';
  static const String nameField = 'name';
  static const String extraCategoryField = 'extra';
  static const String iconNameField = 'icon_name';

  final String id;
  final LocalizedModel localizedName;
  final String name;
  final String iconName;
  final bool isExtraCategory;

  CategoryPlainModel({
    @required this.id,
    @required this.localizedName,
    @required this.name,
    @required this.isExtraCategory,
    @required this.iconName,
  });

  CategoryPlainModel.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        name = json[nameField],
        localizedName = LocalizedModel.fromMap(json[localizedNameField]),
        isExtraCategory = json[extraCategoryField] ?? false,
        iconName = json[iconNameField];

  @override
  List<Object> get props {
    return [
      id,
      localizedName,
      name,
      iconName,
      isExtraCategory,
    ];
  }

  @override
  bool get stringify => true;
}

class SelectableSubCategory {
  String id;
  String name;
  bool selected;
  SelectableSubCategory({this.id, this.name, selected = false});
  SelectableSubCategory.fromCategoryModel(CategoryPlainModel m)
      : id = m.id,
        name = m.name,
        selected = false;
}

class SelectableCategory {
  String id;
  String name;
  bool selected;
  String icon;
  List<SelectableSubCategory> subCategories;
  SelectableCategory(
      {this.id,
      this.name,
      this.icon,
      this.subCategories,
      this.selected = false});
  factory SelectableCategory.fromCategoriesTreeModel(
      CategoriesTreeModel model) {
    var icon;
    if (model.categoryDetails?.iconName != null) {
      icon = 'assets/images/${model.categoryDetails.iconName}.png';
    }
    List<SelectableSubCategory> subs = model.subCategories
        .map((e) => SelectableSubCategory.fromCategoryModel(e.categoryDetails))
        .toList();
    return SelectableCategory(
        id: model.categoryDetails.id,
        name: model.categoryDetails.name,
        icon: icon,
        subCategories: subs);
  }
}
