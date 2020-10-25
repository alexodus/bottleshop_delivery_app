import 'package:bottleshopdeliveryapp/src/features/orders/data/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class CartItemModel extends Equatable {
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
  List<Object> get props => [
        count,
        product,
        promoCode,
        paidPrice,
      ];

  @override
  bool get stringify => true;
}
