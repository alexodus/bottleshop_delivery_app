import 'package:bottleshopdeliveryapp/src/core/data/models/localized_model.dart';
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
        iconName = json[iconNameField] ?? 'default';

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
