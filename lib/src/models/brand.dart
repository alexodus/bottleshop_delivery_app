import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Brand {
  String id = UniqueKey().toString();
  String name;
  String logo;
  bool selected;
  double rate;
  List<Product> products;
  Color color;

  Brand(this.name, this.logo, this.color, this.selected, this.rate,
      this.products);
}
