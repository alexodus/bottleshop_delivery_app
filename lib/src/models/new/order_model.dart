import 'package:bottleshopdeliveryapp/src/models/new/order_type_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/product_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/user_model.dart';
import 'package:flutter/material.dart';

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

  // fields after data join
  static const String userField = 'customer';
  static const String orderTypeField = 'order_type';

  final int id;
  final UserModel customer;
  final OrderTypeModel orderType;
  final String note;
  final List<CartItemModel> cartItems;
  final double totalPaid;
  final int statusStepId;
  final List<DateTime> statusStepsDates;

  bool get isComplete =>
      statusStepId + 1 == orderType.statusStepsToCompleteOrder;

  OrderModel({
    @required this.id,
    @required this.customer,
    @required this.orderType,
    @required this.note,
    @required this.cartItems,
    @required this.totalPaid,
    @required this.statusStepId,
    @required this.statusStepsDates,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : assert(json[orderTypeField] is OrderTypeModel),
        assert(json[userField] is UserModel),
        assert(
            json[statusStepIdField] + 1 == json[statusTimestampsField].length),
        id = json[idField],
        customer = json[userField],
        orderType = json[orderTypeField],
        note = json[noteField],
        cartItems = List<CartItemModel>.from(
            json[cartItemsField].map((e) => CartItemModel.fromJson(e))),
        totalPaid = json[totalPaidField],
        statusStepId = json[statusStepIdField],
        statusStepsDates = List<DateTime>.from(json[statusTimestampsField]
            .map((e) => DateTime.fromMillisecondsSinceEpoch(e.seconds * 1000)));

  @override
  bool operator ==(other) =>
      other is OrderModel &&
      other.id == id &&
      other.customer == customer &&
      other.orderType == orderType &&
      other.note == note &&
      other.cartItems == cartItems &&
      other.totalPaid == totalPaid &&
      other.statusStepId == statusStepId &&
      other.statusStepsDates == statusStepsDates;

  @override
  int get hashCode =>
      id.hashCode ^
      customer.hashCode ^
      orderType.hashCode ^
      note.hashCode ^
      cartItems.hashCode ^
      totalPaid.hashCode ^
      statusStepId.hashCode ^
      statusStepsDates.hashCode;
}

@immutable
class CartItemModel {
  static const String countField = 'count';
  static const String productField = 'product';
  static const String promoCodeField = 'promo_code';
  static const String paidPriceField = 'paid_price';

  final int count;
  final ProductModel product;
  final PromoCodeItemModel promoCode;
  final double paidPrice;

  CartItemModel({
    @required this.count,
    @required this.product,
    @required this.promoCode,
    @required this.paidPrice,
  });

  CartItemModel.fromJson(Map<String, dynamic> json)
      : assert(json[productField] is ProductModel),
        count = json[countField],
        product = json[productField],
        promoCode = PromoCodeItemModel.fromJson(json[promoCodeField]),
        paidPrice = json[paidPriceField];

  @override
  bool operator ==(other) =>
      other is CartItemModel &&
      other.count == count &&
      other.product == product &&
      other.promoCode == promoCode &&
      other.paidPrice == paidPrice;

  @override
  int get hashCode =>
      count.hashCode ^
      product.hashCode ^
      promoCode.hashCode ^
      paidPrice.hashCode;
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
