import 'package:bottleshopdeliveryapp/src/models/order_type_model.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'cart_item_model.dart';

enum OrderStatus { ordered, ready, shipped, closed }

@immutable
class OrderModel {
  // firebase json fields
  static const String idField = 'id';
  static const String noteField = 'note';
  static const String cartItemsField = 'cart';
  static const String totalPaidField = 'total_paid';
  static const String userRefField = 'customer_ref';
  static const String orderTypeRefField = 'order_type_ref';
  static const String statusStepIdField = 'status_step_id';
  static const String statusTimestampsField = 'status_timestamps';
  static const String createdAtTimestampField = 'created_at';
  static const String preparingAdminRefField = 'preparing_admin_ref';

  // fields after data join
  static const String userField = 'customer';
  static const String orderTypeField = 'order_type';
  static const String preparingAdminField = 'preparing_admin';

  final String id;
  final int orderId;
  final User customer;
  final OrderTypeModel orderType;
  final String note;
  final List<CartItemModel> _cartItems;
  final double totalPaid;
  final int statusStepId;
  final List<DateTime> _statusStepsDates;

  List<CartItemModel> get cartItems => _cartItems;

  List<DateTime> get statusStepsDates => _statusStepsDates;

  bool get isComplete => statusStepId == orderType.orderStepsIds.last;

  bool get isFollowingStatusIdComplete =>
      isComplete || getFollowingStatusId == orderType.orderStepsIds.last;

  int get getFollowingStatusId {
    assert(!isComplete);
    return orderType
        .orderStepsIds[orderType.orderStepsIds.indexOf(statusStepId) + 1];
  }

  OrderModel({
    @required this.id,
    @required this.orderId,
    @required this.customer,
    @required this.orderType,
    @required this.note,
    @required List<CartItemModel> cartItems,
    @required this.totalPaid,
    @required this.statusStepId,
    @required List<DateTime> statusStepsDates,
  })  : _cartItems = List.unmodifiable(cartItems),
        _statusStepsDates = List.unmodifiable(statusStepsDates);

  OrderModel.fromJson(Map<String, dynamic> json, String id)
      : assert(json[orderTypeField] is OrderTypeModel),
        assert(json[userField] is User),
        assert((json[orderTypeField] as OrderTypeModel)
            .orderStepsIds
            .contains(json[statusStepIdField])),
        assert(json[statusTimestampsField].length > 0),
        assert((json[orderTypeField] as OrderTypeModel)
                    .orderStepsIds
                    .indexOf(json[statusStepIdField]) +
                1 ==
            json[statusTimestampsField].length),
        assert(
            json[preparingAdminField] != null || json[statusStepIdField] == 0),
        id = id,
        orderId = json[idField],
        customer = json[userField],
        orderType = json[orderTypeField],
        note = json[noteField],
        _cartItems = List<CartItemModel>.unmodifiable(
            json[cartItemsField].map((e) => CartItemModel.fromJson(e))),
        totalPaid = json[totalPaidField],
        statusStepId = json[statusStepIdField],
        _statusStepsDates = List<DateTime>.unmodifiable(
            json[statusTimestampsField].map(
                (e) => DateTime.fromMillisecondsSinceEpoch(e.seconds * 1000)));

  @override
  bool operator ==(other) =>
      other is OrderModel &&
      other.id == id &&
      other.orderId == orderId &&
      other.customer == customer &&
      other.orderType == orderType &&
      other.note == note &&
      ListEquality().equals(other.cartItems, cartItems) &&
      other.totalPaid == totalPaid &&
      other.statusStepId == statusStepId &&
      ListEquality().equals(other.statusStepsDates, statusStepsDates);

  @override
  int get hashCode =>
      id.hashCode ^
      orderId.hashCode ^
      customer.hashCode ^
      orderType.hashCode ^
      note.hashCode ^
      cartItems.fold(
          0, (previousValue, element) => previousValue ^ element.hashCode) ^
      totalPaid.hashCode ^
      statusStepId.hashCode ^
      statusStepsDates.fold(
          0, (previousValue, element) => previousValue ^ element.hashCode);
}

@immutable
class PromoCodeItemModel {
  static const String codeField = 'code';
  static const String discountField = 'discount';

  final String code;
  final double discount;

  PromoCodeItemModel({
    @required this.code,
    @required this.discount,
  });

  PromoCodeItemModel.fromJson(Map<String, dynamic> json)
      : code = json[codeField],
        discount = json[discountField];

  @override
  bool operator ==(other) =>
      other is PromoCodeItemModel &&
      other.code == code &&
      other.discount == discount;

  @override
  int get hashCode => code.hashCode ^ discount.hashCode;
}
