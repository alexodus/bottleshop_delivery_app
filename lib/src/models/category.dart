import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:flutter/material.dart';

class Category {
  String id = UniqueKey().toString();
  String name;
  bool selected;
  IconData icon;
  List<Product> products;

  Category(this.name, this.icon, this.selected, this.products);
}

class SubCategory {
  String id = UniqueKey().toString();
  String name;
  bool selected;
  List<Product> products;

  SubCategory(this.name, this.selected, this.products);
}
