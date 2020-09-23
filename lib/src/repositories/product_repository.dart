import 'dart:collection';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/cart_item_model.dart';
import 'package:bottleshopdeliveryapp/src/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/models/category_model.dart';
import 'package:bottleshopdeliveryapp/src/models/category_plain_model.dart';
import 'package:bottleshopdeliveryapp/src/models/country_model.dart';
import 'package:bottleshopdeliveryapp/src/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/models/order_type_model.dart';
import 'package:bottleshopdeliveryapp/src/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/models/unit_model.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:tuple/tuple.dart';

class ProductRepository {
  List<CategoriesTreeModel> _categoriesCache = [];
  static final ProductRepository _instance = ProductRepository._internal();
  final CollectionReference _categoryCollection =
      FirebaseFirestore.instance.collection(Constants.categoriesCollection);
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection(Constants.categoriesCollection);
  final CollectionReference _configCollection =
      FirebaseFirestore.instance.collection(Constants.configurationCollection);

  ProductRepository._internal();

  factory ProductRepository() => _instance;

  Future<ProductModel> parseProductJson(
      Map<String, dynamic> productJson) async {
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

  Future<UnmodifiableListView<CategoriesTreeModel>> fetchCategories() async {
    if (_categoriesCache.isNotEmpty) {
      final docSnapshot = await _categoryCollection.get();
      final docsMap = Map.fromEntries(
          docSnapshot.docs.map((e) => MapEntry(e.id, e.data())));
      _categoriesCache = [
        ...docsMap.entries
            .where((element) => element.value
                .containsKey(CategoriesTreeModel.isMainCategoryField))
            .map((e) =>
                CategoriesTreeModel.fromDocumentsMap(e.value, e.key, docsMap))
            .toList()
      ];
    }
    return _categoriesCache;
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

          result[OrderModel.userField] = model.User.fromMap(userDoc.data());
          result[OrderModel.orderTypeField] =
              OrderTypeModel.fromJson(orderTypeDoc.data(), orderTypeDoc.id);
          result[OrderModel.cartItemsField] = await Future.wait(
            List<Future<dynamic>>.from(
              e.data()[OrderModel.cartItemsField].map(
                (e) async {
                  e[CartItemModel.productField] =
                      await parseProductJson(e[CartItemModel.productField]);
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

  Stream<QuerySnapshot> getProductsOnFlashSale() {
    return _productsCollection.orderBy('flash_sale_until').snapshots();
  }

  Stream<QuerySnapshot> getAllOtherProducts() {
    return _productsCollection
        .where('is_new_entry', isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getNewProducts() {
    return _productsCollection
        .where('is_new_entry', isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getRecommendedProducts() {
    return _productsCollection
        .where('is_recommended', isEqualTo: true)
        .snapshots();
  }

  Future<List<SliderModel>> getSlidersConfig() async {
    var slidersDocument = await _configCollection.doc('0').get();
    List<SliderModel> sliders;
    if (slidersDocument.data()['sliders'] != null) {
      var slidersData =
          slidersDocument.data()['sliders'] as List<Map<String, dynamic>>;
      sliders = <SliderModel>[];
      slidersData.forEach((data) => sliders.add(SliderModel.fromMap(data)));
    }
    return sliders;
  }
}

final productRepositoryProvider = Provider((ref) => ProductRepository());
final categoriesStateProvider = StateNotifierProvider((_) => CategoriesState());

final categoriesProvider =
    FutureProvider((ref) => ProductRepository().fetchCategories());

class CategoriesState extends StateNotifier<Map<String, bool>> {
  CategoriesState() : super(null);

  void selectCategory(String id) {
    state.update(id, (value) => true);
  }

  bool isSelected(String id) {
    return state[id];
  }

  void clearSelection() {
    state.updateAll((key, value) => value = false);
  }
}
