import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:flutter/material.dart';

enum OrderState { toBeShipped, shipped, delivered, inDispute }

@immutable
class Order {
  final String documentId;
  final List<Product> products;
  final DateTime orderPlacedOn;
  final OrderState orderState;
  final double totalValue;
  final double tax;
  final String amountToPayInCents;
  const Order({
    @required this.documentId,
    @required this.products,
    @required this.orderPlacedOn,
    @required this.orderState,
    @required this.totalValue,
    @required this.tax,
    @required this.amountToPayInCents,
  });

  factory Order.fromProducts(List<Product> products) {
    var totalAmount = 0.0;
    products.forEach((product) {
      var total = product.discount != null
          ? product.price - product.price * product.discount
          : product.price;
      totalAmount += total;
    });
    var totalVat = totalAmount - totalAmount / 1.2;
    totalAmount = totalAmount / 1.2;
    var amountToPayInCents = ((totalAmount + totalVat) * 100).toInt();
    return Order(
      documentId: UniqueKey().toString(),
      products: products,
      orderPlacedOn: DateTime.now(),
      orderState: OrderState.toBeShipped,
      totalValue: totalAmount,
      tax: totalVat,
      amountToPayInCents: amountToPayInCents.toString(),
    );
  }
}
