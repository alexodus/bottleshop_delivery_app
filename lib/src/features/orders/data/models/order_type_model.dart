import 'package:bottleshopdeliveryapp/src/core/data/models/localized_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class OrderTypeModel extends Equatable {
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

  OrderTypeModel.fromMap(String id, Map<String, dynamic> data)
      : id = id,
        name = data[nameField],
        localizedName = LocalizedModel.fromMap(data[localizedNameField]),
        _orderStepsIds =
            List.unmodifiable(data[orderStepsIdsField].cast<int>());

  @override
  List<Object> get props => [
        id,
        name,
        localizedName,
      ];

  @override
  bool get stringify => true;
}
