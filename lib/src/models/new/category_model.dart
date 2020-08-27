import 'package:flutter/material.dart';

import 'category_plain_model.dart';

@immutable
class CategoryModel {
  final CategoryPlainModel categoryDetails;
  final CategoryModel subCategory;

  CategoryModel({
    @required this.categoryDetails,
    @required this.subCategory,
  }) : assert(categoryDetails != null);

  @override
  bool operator ==(other) =>
      other is CategoryModel &&
      other.categoryDetails == categoryDetails &&
      other.subCategory == subCategory;

  @override
  int get hashCode => categoryDetails.hashCode ^ subCategory.hashCode;

  static Iterable<String> allNames(CategoryModel model) sync* {
    if (model == null) return;
    yield model.categoryDetails.name;
    yield* allNames(model.subCategory);
  }

  static Iterable<String> allIds(CategoryModel model) sync* {
    if (model == null) return;
    yield model.categoryDetails.id;
    yield* allIds(model.subCategory);
  }
}
