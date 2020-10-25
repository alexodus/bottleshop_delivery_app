import 'package:bottleshopdeliveryapp/src/core/data/res/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PromoCodeModel extends Equatable {
  static const String codeField = 'code';
  static const String remainingUsesCountField = 'remaining_uses_count';
  static const String discountField = 'discount';
  static const String productRefField = 'product_ref';

  final String uid;
  final String code;
  final int remainingUsesCount;
  final double discount;
  final String productUniqueId;

  PromoCodeModel({
    @required this.uid,
    @required this.code,
    @required this.remainingUsesCount,
    @required this.discount,
    @required this.productUniqueId,
  });

  PromoCodeModel.empty(String productUniqueId)
      : uid = null,
        code = null,
        remainingUsesCount = null,
        discount = null,
        productUniqueId = productUniqueId;

  PromoCodeModel.fromJson(Map<String, dynamic> json, String uid)
      : uid = uid,
        code = json[codeField],
        remainingUsesCount = json[remainingUsesCountField],
        discount = json[discountField],
        productUniqueId = (json[productRefField] as DocumentReference).id;

  Map<String, dynamic> toFirebaseJson() {
    return {
      codeField: code,
      remainingUsesCountField: remainingUsesCount,
      discountField: discount,
      productRefField: FirebaseFirestore.instance
          .collection(AppDBConstants.productsCollection)
          .doc(productUniqueId),
    };
  }

  @override
  List<Object> get props => [
        uid,
        code,
        remainingUsesCount,
        discount,
        productUniqueId,
      ];

  @override
  bool get stringify => true;
}
