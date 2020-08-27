import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/new/category_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/country_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/unit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class ProductModel {
  // firebase json fields
  static const String nameField = 'name';
  static const String editionField = 'edition';
  static const String ageField = 'age';
  static const String yearField = 'year';
  static const String cmatField = 'cmat';
  static const String eanField = 'ean';
  static const String priceField = 'price_no_vat';
  static const String countField = 'amount';
  static const String unitsCountField = 'unit_value';
  static const String unitsTypeField = 'unit';
  static const String alcoholField = 'alcohol';
  static const String countryField = 'country';
  static const String descriptionSkField = 'description_sk';
  static const String descriptionEnField = 'description_en';
  static const String discountField = 'discount';
  static const String categoriesField = 'categories';
  static const String isRecommendedField = 'is_recommended';
  static const String isNewEntryField = 'is_new_entry';
  static const String flashSaleUntilField = 'flash_sale_until';

  // fields after data join
  static const String countryRefField = 'country_ref';
  static const String unitsTypeRefField = 'unit_ref';
  static const String categoryRefsField = 'category_refs';

  final String name;
  final String edition;
  final int age;
  final int year;
  final String cmat;
  final String ean;
  final double _price;
  final int count;
  final double unitsCount;
  final UnitModel unitsType;
  final int alcohol;
  final List<CategoryModel> categories;
  final CountryModel country;
  final String descriptionSk;
  final String descriptionEn;
  final double discount;
  final bool isRecommended;
  final bool isNewEntry;
  final DateTime flashSaleUntil;

  String get uniqueId => cmat;
  bool get hasAlcohol => alcohol != null;

  double get priceNoVat => _price;
  double get priceWithVat => _price == null ? null : _price * 1.2;
  double get finalPrice =>
      _price == null ? null : _price * 1.2 * (discount ?? 1);

  const ProductModel({
    this.name,
    @required this.edition,
    @required this.age,
    @required this.year,
    @required this.cmat,
    @required this.ean,
    @required price,
    @required this.count,
    @required this.unitsCount,
    @required this.unitsType,
    @required this.alcohol,
    @required this.categories,
    @required this.country,
    @required this.descriptionSk,
    @required this.descriptionEn,
    @required this.discount,
    @required this.isRecommended,
    @required this.isNewEntry,
    @required this.flashSaleUntil,
  }) : _price = price;

  ProductModel.fromJson(Map<String, dynamic> json)
      : assert(json[countryField] is CountryModel),
        assert(json[unitsTypeField] is UnitModel),
        assert(json[categoriesField] is List<CategoryModel>),
        name = json[nameField],
        edition = json[editionField],
        year = json[yearField],
        age = json[ageField],
        country = json[countryField],
        cmat = json[cmatField],
        ean = json[eanField],
        _price = json[priceField],
        count = json[countField],
        unitsCount = json[unitsCountField],
        unitsType = json[unitsTypeField],
        alcohol = json[alcoholField],
        categories = json[categoriesField],
        descriptionSk = json[descriptionSkField],
        descriptionEn = json[descriptionEnField],
        discount = json[discountField],
        isRecommended = json[isRecommendedField],
        isNewEntry = json[isNewEntryField],
        flashSaleUntil = json[flashSaleUntilField] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                json[flashSaleUntilField].seconds * 1000)
            : null;

  Map<String, dynamic> toFirebaseJson() {
    var result = <String, dynamic>{
      nameField: name,
      editionField: edition,
      yearField: year,
      ageField: age,
      cmatField: cmat,
      eanField: ean,
      priceField: _price,
      countField: count,
      unitsCountField: unitsCount,
      alcoholField: alcohol,
      unitsTypeRefField: Firestore.instance
          .collection(Constants.unitsCollection)
          .document(unitsType.id),
      categoryRefsField: categories
          .expand<DocumentReference>(
            (category) => CategoryModel.allIds(category).map(
              (e) => Firestore.instance
                  .collection(Constants.categoriesCollection)
                  .document(e),
            ),
          )
          .toList(),
      countryRefField: Firestore.instance
          .collection(Constants.countriesCollection)
          .document(country.id),
      descriptionSkField: descriptionSk,
      descriptionEnField: descriptionEn,
      discountField: discount,
      isRecommendedField: isRecommended,
      isNewEntryField: isNewEntry,
      flashSaleUntilField:
          flashSaleUntil != null ? Timestamp.fromDate(flashSaleUntil) : null,
    };
    result.updateAll((key, value) => value ?? FieldValue.delete());
    return result;
  }

  @override
  bool operator ==(other) =>
      other is ProductModel &&
      other.name == name &&
      other.edition == edition &&
      other.age == age &&
      other.year == year &&
      other.cmat == cmat &&
      other.ean == ean &&
      other._price == _price &&
      other.count == count &&
      other.unitsCount == unitsCount &&
      other.unitsType == unitsType &&
      other.alcohol == alcohol &&
      other.categories == categories &&
      other.country == country &&
      other.descriptionSk == descriptionSk &&
      other.descriptionEn == descriptionEn &&
      other.discount == discount &&
      other.isRecommended == isRecommended &&
      other.isNewEntry == isNewEntry &&
      other.flashSaleUntil == flashSaleUntil;

  @override
  int get hashCode =>
      name.hashCode ^
      edition.hashCode ^
      age.hashCode ^
      year.hashCode ^
      cmat.hashCode ^
      ean.hashCode ^
      _price.hashCode ^
      count.hashCode ^
      unitsCount.hashCode ^
      unitsType.hashCode ^
      alcohol.hashCode ^
      categories.hashCode ^
      country.hashCode ^
      descriptionSk.hashCode ^
      descriptionEn.hashCode ^
      discount.hashCode ^
      isRecommended.hashCode ^
      isNewEntry.hashCode ^
      flashSaleUntil.hashCode;
}
