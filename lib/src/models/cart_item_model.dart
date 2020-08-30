import 'package:flutter/foundation.dart';

@immutable
class CartItemModel {
  final String productRef;
  final int quantity;

  const CartItemModel({@required this.productRef, @required this.quantity})
      : assert(productRef != null),
        assert(quantity != null || quantity > 0);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModel &&
          runtimeType == other.runtimeType &&
          productRef == other.productRef &&
          quantity == other.quantity;

  @override
  int get hashCode => productRef.hashCode ^ quantity.hashCode;

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productRef: map['productRef'] as String,
      quantity: map['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'productRef': productRef,
      'quantity': quantity,
    } as Map<String, dynamic>;
  }

  @override
  String toString() {
    return 'CartItemModel{productRef: $productRef, quantity: $quantity}';
  }
}
