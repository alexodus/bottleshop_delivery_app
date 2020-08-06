import 'package:flutter/foundation.dart';

@immutable
class Product {
  final String documentID;
  final String name;
  final String edition;
  final String year;
  final int age;
  final String category;
  final String subCategory;
  final String additionalSubCategory;
  final String country;
  final int amount;
  final double unitValue;
  final String unit;
  final String alcohol;
  final double price;
  final String description;
  final String descriptionLocalized;
  final double discount;
  final bool newEntry;
  final bool recommended;
  final DateTime flashSaleUntil;
  final String imageUrl;

  const Product({
    @required this.documentID,
    this.name,
    this.imageUrl,
    this.price,
    this.discount,
    this.amount,
    this.country,
    this.alcohol,
    this.category,
    this.subCategory,
    this.additionalSubCategory,
    this.description,
    this.descriptionLocalized,
    this.edition,
    this.year,
    this.age,
    this.unitValue,
    this.unit,
    this.newEntry,
    this.recommended,
    this.flashSaleUntil,
  });

  factory Product.fromMap(Map<String, dynamic> data, String documentID) {
    return Product(
      documentID: documentID,
      name: data['name'],
      imageUrl: data['cmat'],
      price: double.tryParse(data['price']) ?? 0.0,
      discount: double.tryParse(data['discount']) ?? 0.0,
      amount: int.tryParse(data['amount']) ?? 0,
      country: data['country'] ?? 'N/A',
      alcohol: data['alcohol'] ?? 'N/A',
      description: data['description'],
      descriptionLocalized: data['descriptionLocalized'],
      edition: data['edition'],
      year: data['year'],
      age: int.tryParse(data['age']) ?? 0,
      unitValue: double.tryParse(data['unitValue']) ?? 0.0,
      unit: data['unit'] ?? 'N/A',
      newEntry: data['newEntry'] == 'y' ? true : false ?? false,
      recommended: data['recommended'] == 'y' ? true : false ?? false,
      flashSaleUntil: DateTime.tryParse(data['flashSaleUntil']),
    );
  }
}
