import 'package:bottleshopdeliveryapp/src/models/product_model.dart';
import 'package:flutter/foundation.dart';

import 'order_model.dart';

@immutable
class CartItemModel {
  static const String countField = 'count';
  static const String productField = 'product';
  static const String promoCodeField = 'promo_code';
  static const String paidPriceField = 'paid_price';

  final int count;
  final ProductModel product;
  final PromoCodeItemModel promoCode;
  final double paidPrice;

  CartItemModel({
    @required this.count,
    @required this.product,
    @required this.promoCode,
    @required this.paidPrice,
  });

  CartItemModel.fromJson(Map<String, dynamic> json)
      : assert(json[productField] is ProductModel),
        count = json[countField],
        product = json[productField],
        promoCode = PromoCodeItemModel.fromJson(json[promoCodeField]),
        paidPrice = json[paidPriceField];

  @override
  bool operator ==(other) =>
      other is CartItemModel &&
      other.count == count &&
      other.product == product &&
      other.promoCode == promoCode &&
      other.paidPrice == paidPrice;

  @override
  int get hashCode =>
      count.hashCode ^
      product.hashCode ^
      promoCode.hashCode ^
      paidPrice.hashCode;
}
