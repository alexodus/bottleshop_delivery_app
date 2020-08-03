import 'dart:math';

import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

enum OrderState { toBeShipped, shipped, delivered, inDispute }

class Track {
  String id = UniqueKey().toString();
  String description;
  String currentLocation;
  DateTime dateTime;

  Track(this.description, this.currentLocation, this.dateTime);

  static List<Track> getTrackingList() {
    return [
      Track('Your Order in local post', 'United State', DateTime.now().subtract(Duration(days: 1))),
      Track('Your Order arrived in destination', 'United State', DateTime.now().subtract(Duration(days: 5))),
      Track('Order in aeroport', 'France', DateTime.now().subtract(Duration(days: 8))),
      Track('Your order oversea in china', 'China', DateTime.now().subtract(Duration(days: 10))),
    ];
  }
}

class Order {
  String id = UniqueKey().toString();
  Product product;
  int quantity = Random().nextInt(10);
  String trackingNumber;
  DateTime dateTime = DateTime.now().subtract(Duration(days: Random().nextInt(20)));
  OrderState orderState;
  List<Track> tracking = Track.getTrackingList();

  Order(this.product, this.trackingNumber, this.orderState);

  get totalValue => null;

  getDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm').format(this.dateTime);
  }
}
