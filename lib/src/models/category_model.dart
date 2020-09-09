import 'package:bottleshopdeliveryapp/src/models/category_plain_model.dart';
import 'package:flutter/material.dart';

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

  static Iterable<CategoryPlainModel> allCategoryDetails(
      CategoryModel model) sync* {
    if (model == null) return;
    yield model.categoryDetails;
    yield* allCategoryDetails(model.subCategory);
  }

  static Iterable<String> allLocalizedNames(CategoryModel model) sync* {
    if (model == null) return;
    yield model.categoryDetails.localizedName.local;
    yield* allLocalizedNames(model.subCategory);
  }

  static Iterable<String> allIds(CategoryModel model) sync* {
    if (model == null) return;
    yield model.categoryDetails.id;
    yield* allIds(model.subCategory);
  }

  @override
  String toString() {
    return 'CategoryModel{categoryDetails: $categoryDetails, subCategory: $subCategory}';
  }
}
