import 'dart:async';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/new/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/category_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/category_plain_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/country_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/order_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/order_type_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/product_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/unit_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';

class FirestoreService {
  DocumentSnapshot _lastDocument;

  final StreamController<List<ProductModel>> _productsStreamCtrl =
      StreamController();

  // ignore: close_sinks
  final StreamController<List<ProductModel>> _productDeletesStreamCtrl =
      StreamController();

  Stream<List<ProductModel>> get productsStream => _productsStreamCtrl.stream;

  Stream<List<ProductModel>> get productDeletesStream =>
      _productDeletesStreamCtrl.stream;

  Future<List<CountryModel>> countries() async {
    final docs = await Firestore.instance
        .collection(Constants.countriesCollection)
        .getDocuments();
    final docsMap = Map.fromEntries(
        docs.documents.map((e) => MapEntry(e.documentID, e.data)));
    return docsMap.entries
        .map((e) => CountryModel.fromJson(e.value, e.key))
        .toList();
  }

  Future<List<CategoriesTreeModel>> categories() async {
    final docs = await Firestore.instance
        .collection(Constants.categoriesCollection)
        .getDocuments();
    final docsMap = Map.fromEntries(
        docs.documents.map((e) => MapEntry(e.documentID, e.data)));
    return docsMap.entries
        .where((element) =>
            element.value.containsKey(CategoriesTreeModel.isMainCategoryField))
        .map((e) =>
            CategoriesTreeModel.fromDocumentsMap(e.value, e.key, docsMap))
        .toList();
  }

  Future<List<UnitModel>> units() async {
    final docs = await Firestore.instance
        .collection(Constants.unitsCollection)
        .getDocuments();
    final docsMap = Map.fromEntries(
        docs.documents.map((e) => MapEntry(e.documentID, e.data)));
    return docsMap.entries
        .map((e) => UnitModel.fromJson(e.value, e.key))
        .toList();
  }

  Future<List<OrderTypeModel>> orderTypes() async {
    final docs = await Firestore.instance
        .collection(Constants.orderTypesCollection)
        .getDocuments();
    final docsMap = Map.fromEntries(
        docs.documents.map((e) => MapEntry(e.documentID, e.data)));
    return docsMap.entries
        .map((e) => OrderTypeModel.fromJson(e.value, e.key))
        .toList();
  }

  Future<List<CategoryModel>> categoriesByRefs(
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
        categoryDetails: CategoryPlainModel.fromJson(doc.data, doc.documentID),
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
            .data
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

  Future<List<OrderModel>> orders() async {
    final docs = await Firestore.instance
        .collection(Constants.ordersCollection)
        .getDocuments();
    return await Future.wait(
      docs.documents.map(
        (e) async {
          final result = Map<String, dynamic>.from(e.data);

          final DocumentSnapshot userDoc =
              await e.data[OrderModel.userRefField].get();
          final DocumentSnapshot orderTypeDoc =
              await e.data[OrderModel.orderTypeRefField].get();

          if (!userDoc.exists || !orderTypeDoc.exists) {
            return Future.error('missing reference');
          }

          result[OrderModel.userField] = UserModel.fromJson(userDoc.data);
          result[OrderModel.orderTypeField] = OrderTypeModel.fromJson(
              orderTypeDoc.data, orderTypeDoc.documentID);
          result[OrderModel.cartItemsField] = await Future.wait(
            List<Future<dynamic>>.from(
              e.data[OrderModel.cartItemsField].map(
                (e) async {
                  e[CartItemModel.productField] =
                      await _parseProductJson(e[CartItemModel.productField]);
                  return e;
                },
              ),
            ),
          );
          return OrderModel.fromJson(result, e.documentID);
        },
      ),
    );
  }

  void requestMoreProductsData() {
    var query = Firestore.instance
        .collection(Constants.productsCollection)
        .orderBy(ProductModel.nameField)
        .limit(10);
    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument);
    }

    query.snapshots().listen((snapshot) async {
      final removed = snapshot.documentChanges
          .where((element) => element.type == DocumentChangeType.removed);

      if (removed.isNotEmpty) {
        final removedParsed = await Future.wait(
          removed.map(
            (e) => _parseProductJson(e.document.data),
          ),
        );

        _productDeletesStreamCtrl.add(removedParsed);
      }

      if (snapshot.documents.isEmpty) {
        _productsStreamCtrl.add([]);
      } else {
        _lastDocument = snapshot.documents.last;

        final newProducts = await Future.wait(
          snapshot.documents.map(
            (e) {
              return _parseProductJson(e.data);
            },
          ),
        );

        _productsStreamCtrl.add(newProducts);
      }
    });
  }

  Future<ProductModel> _parseProductJson(
    Map<String, dynamic> productJson,
  ) async {
    final DocumentSnapshot countryDoc =
        await productJson[ProductModel.countryRefField].get();
    final DocumentSnapshot unitDoc =
        await productJson[ProductModel.unitsTypeRefField].get();

    if (!countryDoc.exists || !unitDoc.exists) {
      return Future.error('Missing reference');
    }

    productJson[ProductModel.categoriesField] = await categoriesByRefs(
        productJson[ProductModel.categoryRefsField].cast<DocumentReference>());
    productJson[ProductModel.countryField] =
        CountryModel.fromJson(countryDoc.data, countryDoc.documentID);
    productJson[ProductModel.unitsTypeField] =
        UnitModel.fromJson(unitDoc.data, unitDoc.documentID);

    return ProductModel.fromJson(productJson);
  }
}
