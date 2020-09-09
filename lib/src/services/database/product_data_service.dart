import 'dart:async';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/models/category_model.dart';
import 'package:bottleshopdeliveryapp/src/models/category_plain_model.dart';
import 'package:bottleshopdeliveryapp/src/models/country_model.dart';
import 'package:bottleshopdeliveryapp/src/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/models/order_type_model.dart';
import 'package:bottleshopdeliveryapp/src/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/models/unit_model.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

class ProductDataService {
  final FirebaseFirestore _firestoreInstance;

  ProductDataService({FirebaseFirestore firestore})
      : _firestoreInstance = firestore ?? FirebaseFirestore.instance;

  Future<ProductModel> parseProductJson(
    Map<String, dynamic> productJson,
  ) async {
    final DocumentSnapshot countryDoc =
        await productJson[ProductModel.countryRefField].get();
    final DocumentSnapshot unitDoc =
        await productJson[ProductModel.unitsTypeRefField].get();

    if (!countryDoc.exists || !unitDoc.exists) {
      return Future.error('Missing reference');
    }

    productJson[ProductModel.categoriesField] = await _categoriesByRefs(
        productJson[ProductModel.categoryRefsField].cast<DocumentReference>());
    productJson[ProductModel.countryField] =
        CountryModel.fromJson(countryDoc.data(), countryDoc.id);
    productJson[ProductModel.unitsTypeField] =
        UnitModel.fromJson(unitDoc.data(), unitDoc.id);

    return ProductModel.fromJson(productJson);
  }

  Future<List<CategoryModel>> _categoriesByRefs(
      List<DocumentReference> refs) async {
    final docs = await Future.wait(refs.map((e) => e.get()));
    if (docs.any((element) => !element.exists)) {
      throw Exception('All categories haven\'t been found');
    }

    CategoryModel _parseCategories(
      Iterable<DocumentSnapshot> categories,
    ) {
      if (categories.isEmpty) return null;
      final doc = categories.first;
      return CategoryModel(
        categoryDetails: CategoryPlainModel.fromJson(doc.data(), doc.id),
        subCategory: _parseCategories(categories.skip(1)),
      );
    }

    Iterable<int> _categoriesCounts(
      List<DocumentSnapshot> allCategories,
    ) sync* {
      if (allCategories.isEmpty) return;
      for (var i = 0; i < allCategories.length; i++) {
        if (i == 0) continue;
        if (allCategories[i]
            .data()
            .containsKey(CategoriesTreeModel.isMainCategoryField)) {
          yield i;
          yield* _categoriesCounts(allCategories.skip(i).toList());
          return;
        }
      }
      yield allCategories.length;
    }

    final result = _categoriesCounts(docs).fold(
      Tuple2(0, Iterable<CategoryModel>.empty()),
      (previousValue, element) => Tuple2(
        previousValue.item1 + element,
        previousValue.item2.followedBy(
          [_parseCategories(docs.skip(previousValue.item1).take(element))],
        ),
      ),
    );

    assert(result.item1 == docs.length);

    return result.item2.toList();
  }

  Future<List<CountryModel>> countries() async {
    final docs = await FirebaseFirestore.instance
        .collection(Constants.countriesCollection)
        .get();
    final docsMap = Map.fromEntries(
      docs.docs.map(
        (e) => MapEntry(
          e.id,
          e.data,
        ),
      ),
    );
    return docsMap.entries
        .map((e) => CountryModel.fromJson(e.value(), e.key))
        .toList();
  }

  Future<List<CategoriesTreeModel>> categories() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection(Constants.categoriesCollection)
        .get();
    final docsMap =
        Map.fromEntries(docSnapshot.docs.map((e) => MapEntry(e.id, e.data())));
    return docsMap.entries
        .where((element) =>
            element.value.containsKey(CategoriesTreeModel.isMainCategoryField))
        .map((e) =>
            CategoriesTreeModel.fromDocumentsMap(e.value, e.key, docsMap))
        .toList();
  }

  Future<List<UnitModel>> units() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection(Constants.unitsCollection)
        .get();
    final docsMap =
        Map.fromEntries(docSnapshot.docs.map((e) => MapEntry(e.id, e.data())));
    return docsMap.entries
        .map((e) => UnitModel.fromJson(e.value, e.key))
        .toList();
  }

  Future<List<OrderTypeModel>> orderTypes() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection(Constants.orderTypesCollection)
        .get();
    final docsMap =
        Map.fromEntries(docSnapshot.docs.map((e) => MapEntry(e.id, e.data())));
    return docsMap.entries
        .map((e) => OrderTypeModel.fromJson(e.value, e.key))
        .toList();
  }

  Future<List<OrderModel>> orders() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection(Constants.ordersCollection)
        .get();
    return await Future.wait(
      docSnapshot.docs.map(
        (e) async {
          final result = Map<String, dynamic>.from(e.data());

          final DocumentSnapshot userDoc =
              await e.data()[OrderModel.userRefField].get();
          final DocumentSnapshot orderTypeDoc =
              await e.data()[OrderModel.orderTypeRefField].get();

          if (!userDoc.exists || !orderTypeDoc.exists) {
            return Future.error('missing reference');
          }

          result[OrderModel.userField] = User.fromMap(userDoc.data());
          result[OrderModel.orderTypeField] =
              OrderTypeModel.fromJson(orderTypeDoc.data(), orderTypeDoc.id);
          result[OrderModel.cartItemsField] = await Future.wait(
            List<Future<dynamic>>.from(
              e.data()[OrderModel.cartItemsField].map(
                (e) async {
                  e[CartItemModel.productField] =
                      await _parseProductJson(e[CartItemModel.productField]);
                  return e;
                },
              ),
            ),
          );
          return OrderModel.fromJson(result, e.id);
        },
      ),
    );
  }

  Future<ProductModel> _parseProductJson(
      Map<String, dynamic> productJson) async {
    final DocumentSnapshot countryDoc =
        await productJson[ProductModel.countryRefField].get();
    final DocumentSnapshot unitDoc =
        await productJson[ProductModel.unitsTypeRefField].get();
    if (!countryDoc.exists || !unitDoc.exists) {
      return Future.error('Missing reference');
    }
    productJson[ProductModel.categoriesField] = await _categoriesByRefs(
      productJson[ProductModel.categoryRefsField].cast<DocumentReference>(),
    );
    productJson[ProductModel.countryField] =
        CountryModel.fromJson(countryDoc.data(), countryDoc.id);
    productJson[ProductModel.unitsTypeField] =
        UnitModel.fromJson(unitDoc.data(), unitDoc.id);
    return ProductModel.fromJson(productJson);
  }

  Future<List<SliderModel>> getSlidersConfig() async {
    var slidersDocument = await _firestoreInstance
        .collection(Constants.configurationCollection)
        .doc('0')
        .get();
    List<SliderModel> sliders;
    if (slidersDocument.data()['sliders'] != null) {
      var slidersData = slidersDocument.data()['sliders'];
      sliders = <SliderModel>[];
      slidersData.forEach((data) => sliders.add(SliderModel.fromMap(data)));
    }
    return sliders;
  }

  Stream<QuerySnapshot> getProductsOnFlashSale() {
    return _firestoreInstance
        .collection(Constants.productsCollection)
        .orderBy('flash_sale_until')
        .snapshots();
  }

  Stream<QuerySnapshot> getAllOtherProducts() {
    return _firestoreInstance
        .collection(Constants.productsCollection)
        .where('is_new_entry', isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getNewProducts() {
    return _firestoreInstance
        .collection(Constants.productsCollection)
        .where('is_new_entry', isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getRecommendedProducts() {
    return _firestoreInstance
        .collection(Constants.productsCollection)
        .where('is_recommended', isEqualTo: true)
        .snapshots();
  }
}
