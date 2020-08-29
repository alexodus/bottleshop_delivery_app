import 'package:bottleshopdeliveryapp/src/models/new/localized_model.dart';
import 'package:flutter/material.dart';

@immutable
class OrderTypeModel {
  static const String nameField = 'name';
  static const String localizedNameField = 'localized_name';
  static const String statusStepsToCompleteOrderField =
      'status_steps_to_complete_order';

  final String id;
  final String name;
  final LocalizedModel localizedName;
  final int statusStepsToCompleteOrder;

  OrderTypeModel({
    @required this.id,
    @required this.name,
    @required this.localizedName,
    @required this.statusStepsToCompleteOrder,
  });

  OrderTypeModel.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        name = json[nameField],
        localizedName = LocalizedModel.fromJson(json[localizedNameField]),
        statusStepsToCompleteOrder = json[statusStepsToCompleteOrderField];

  @override
  bool operator ==(other) =>
      other is OrderTypeModel &&
      other.id == id &&
      other.name == name &&
      other.localizedName == localizedName &&
      other.statusStepsToCompleteOrder == statusStepsToCompleteOrder;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      localizedName.hashCode ^
      statusStepsToCompleteOrder.hashCode;
}
