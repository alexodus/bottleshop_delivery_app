import 'package:bottleshopdeliveryapp/src/models/new/localized_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

@immutable
class OrderTypeModel {
  static const String nameField = 'name';
  static const String localizedNameField = 'localized_name';
  static const String orderStepsIdsField = 'order_steps_ids';

  final String id;
  final String name;
  final LocalizedModel localizedName;
  final List<int> _orderStepsIds;

  List<int> get orderStepsIds => _orderStepsIds;

  OrderTypeModel({
    @required this.id,
    @required this.name,
    @required this.localizedName,
    @required List<int> orderStepsIds,
  }) : _orderStepsIds = List.unmodifiable(orderStepsIds);

  OrderTypeModel.fromJson(Map<String, dynamic> json, String id)
      : id = id,
        name = json[nameField],
        localizedName = LocalizedModel.fromJson(json[localizedNameField]),
        _orderStepsIds =
            List.unmodifiable(json[orderStepsIdsField].cast<int>());

  @override
  bool operator ==(other) =>
      other is OrderTypeModel &&
      other.id == id &&
      other.name == name &&
      other.localizedName == localizedName &&
      ListEquality().equals(other.orderStepsIds, orderStepsIds);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      localizedName.hashCode ^
      orderStepsIds.fold(
          0, (previousValue, element) => previousValue ^ element.hashCode);
}
