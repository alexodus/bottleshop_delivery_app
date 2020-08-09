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
  const Order(
      {this.documentId,
      @required this.products,
      this.orderPlacedOn,
      this.orderState,
      this.totalValue,
      this.tax});
}
