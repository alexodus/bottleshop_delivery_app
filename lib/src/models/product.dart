import 'package:flutter/material.dart';

class Product {
  String id = UniqueKey().toString();
  String name;
  String image;
  //String description;
  double price;
  int available;
  int quantity;
  int sales;
  double rate;
  double discount;

  Product(this.name, this.image, this.available, this.price, this.quantity,
      this.sales, this.rate, this.discount);

  String getPrice({double myPrice}) {
    if (myPrice != null) {
      return '\$${myPrice.toStringAsFixed(2)}';
    }
    return '\$${this.price.toStringAsFixed(2)}';
  }
}
