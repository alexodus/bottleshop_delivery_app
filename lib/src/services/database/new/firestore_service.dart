import 'dart:async';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/new/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/category_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/category_plain_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/country_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/order_type_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/product_model.dart';
import 'package:bottleshopdeliveryapp/src/models/new/unit_model.dart';
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
    final docs = await FirebaseFirestore.instance
        .collection(Constants.countriesCollection)
        .get();
    final docsMap =
        Map.fromEntries(docs.docs.map((e) => MapEntry(e.id, e.data())));
    return docsMap.entries
        .map((e) => CountryModel.fromJson(e.value, e.key))
        .toList();
  }

  Future<List<CategoriesTreeModel>> categories() async {
    final docs = await FirebaseFirestore.instance
        .collection(Constants.categoriesCollection)
        .get();
    final docsMap =
        Map.fromEntries(docs.docs.map((e) => MapEntry(e.id, e.data())));
    return docsMap.entries
        .where((element) =>
            element.value.containsKey(CategoriesTreeModel.isMainCategoryField))
        .map((e) =>
            CategoriesTreeModel.fromDocumentsMap(e.value, e.key, docsMap))
        .toList();
  }

  Future<List<UnitModel>> units() async {
    final docs = await FirebaseFirestore.instance
        .collection(Constants.unitsCollection)
        .get();
    final docsMap =
        Map.fromEntries(docs.docs.map((e) => MapEntry(e.id, e.data)));
    return docsMap.entries
        .map((e) => UnitModel.fromJson(e.value(), e.key))
        .toList();
  }

  Future<List<OrderTypeModel>> orderTypes() async {
    final docs = await FirebaseFirestore.instance
        .collection(Constants.orderTypesCollection)
        .get();
    final docsMap =
        Map.fromEntries(docs.docs.map((e) => MapEntry(e.id, e.data())));
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

  void requestMoreProductsData() {
    var query = FirebaseFirestore.instance
        .collection(Constants.productsCollection)
        .orderBy(ProductModel.nameField)
        .limit(10);
    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument);
    }

    query.snapshots().listen((snapshot) async {
      final removed = snapshot.docChanges
          .where((element) => element.type == DocumentChangeType.removed);

      if (removed.isNotEmpty) {
        final removedParsed = await Future.wait(
          removed.map(
            (e) => _parseProductJson(e.doc.data()),
          ),
        );

        _productDeletesStreamCtrl.add(removedParsed);
      }

      if (snapshot.docs.isEmpty) {
        _productsStreamCtrl.add([]);
      } else {
        _lastDocument = snapshot.docs.last;

        final newProducts = await Future.wait(
          snapshot.docs.map(
            (e) => _parseProductJson(e.data()),
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
        CountryModel.fromJson(countryDoc.data(), countryDoc.id);
    productJson[ProductModel.unitsTypeField] =
        UnitModel.fromJson(unitDoc.data(), unitDoc.id);

    return ProductModel.fromJson(productJson);
  }
}
