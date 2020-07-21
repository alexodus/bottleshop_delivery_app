import 'package:flutter/foundation.dart';

@immutable
class Product {
  final String cmat;
  final String name;
  final String image;
  final double price;
  final int amount;
  final String country;
  final String alcohol;
  final String volume;
  final String category;
  final String description;
  final String descriptionLocalized;
  final double discount;
  final String documentID;

  const Product(
      {@required this.documentID,
      @required this.cmat,
      this.name,
      this.image,
      this.price,
      this.discount,
      this.amount,
      this.country,
      this.alcohol,
      this.volume,
      this.category,
      this.description,
      this.descriptionLocalized});

  factory Product.fromMap(Map<String, dynamic> data, String documentID) {
    return Product(
      name: data['name'],
      image: data['image'],
      price: data['price'],
      discount: data['discount'],
      amount: data['amount'],
      country: data['country'],
      alcohol: data['alcohol'],
      volume: data['volume'],
      category: data['category'],
      description: data['description'],
      descriptionLocalized: data['descriptionLocalized'],
      cmat: data['cmat'],
      documentID: documentID,
    );
  }
}
