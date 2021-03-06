import 'package:bottleshopdeliveryapp/src/core/data/models/country_model.dart';
import 'package:bottleshopdeliveryapp/src/core/data/models/unit_model.dart';
import 'package:bottleshopdeliveryapp/src/core/data/res/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/database_service.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:bottleshopdeliveryapp/src/features/home/data/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/features/home/data/services/db_service.dart';
import 'package:bottleshopdeliveryapp/src/features/orders/data/models/order_type_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/category_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/category_plain_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/services/db_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';

class FirestoreJsonParsingUtil {
  FirestoreJsonParsingUtil._();

  static Future<ProductModel> parseProductJson(
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
        CountryModel.fromMap(countryDoc.id, countryDoc.data());
    productJson[ProductModel.unitsTypeField] =
        UnitModel.fromMap(unitDoc.id, unitDoc.data());
    return ProductModel.fromJson(productJson);
  }

  static Future<List<CategoryModel>> _categoriesByRefs(
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
}

class ProductRepository with ChangeNotifier {
  Logger _logger;
  String _error;
  bool _loading;
  bool initialized = false;
  List<CountryModel> _countries = [];
  List<CategoriesTreeModel> _categories = [];
  List<UnitModel> _units = [];
  List<OrderTypeModel> _orderTypes = [];
  List<SelectableCategory> _selectableCategories = [];

  String get error => _error;

  bool get isLoading => _loading;

  List<CountryModel> get countries => _countries;
  List<CategoriesTreeModel> get categories => _categories;
  List<UnitModel> get units => _units;
  List<OrderTypeModel> get orderTypes => _orderTypes;
  List<SelectableCategory> get selectableCategories => _selectableCategories;

  ProductRepository.instance() {
    _loading = true;
    _error = '';
    _logger = createLogger(this.runtimeType.toString());
    _logger.v('created');
  }

  Future<void> init() async {
    if (!initialized) {
      try {
        var data = await Future.wait([
          _getCategories(),
          _getCountries(),
          _getOrderTypes(),
          _getUnits(),
        ]);
        _categories = data[0];
        _countries = data[1];
        _orderTypes = data[2];
        _units = data[3];
        _selectableCategories = _categories
            .map((e) => SelectableCategory.fromCategoriesTreeModel(e))
            .toList();
        initialized = true;
        _loading = false;
        notifyListeners();
      } catch (e) {
        _logger.e('failed to fetch data: $e');
        _error = e.message;
        _loading = false;
        return initialized;
      }
    }
  }

  void selectCategory(String id) {
    _selectableCategories.forEach((SelectableCategory category) {
      category.selected = false;
      if (category.id == id) {
        category.selected = true;
      }
    });
    notifyListeners();
  }

  void clearSelection() {
    _selectableCategories.forEach((SelectableCategory category) {
      category.selected = false;
      category.subCategories
          .forEach((subCategory) => subCategory.selected = false);
    });
    notifyListeners();
  }

  selectSubCategory(String id) {
    _selectableCategories
        .firstWhere((element) => element.selected)
        ?.subCategories
        ?.forEach((subCategory) {
      subCategory.selected = false;
      if (subCategory.id == id) {
        subCategory.selected = true;
      }
    });
    notifyListeners();
  }

  bool isCategorySelected(String id) {
    return _selectableCategories
            .firstWhere((element) => element.id == id)
            .selected ??
        false;
  }

  Future<List<CountryModel>> _getCountries() async {
    final docs = await FirebaseFirestore.instance
        .collection(AppDBConstants.countriesCollection)
        .get();
    final docsMap =
        Map.fromEntries(docs.docs.map((e) => MapEntry(e.id, e.data())));
    return docsMap.entries
        .map((e) => CountryModel.fromMap(e.key, e.value))
        .toList();
  }

  Future<List<CategoriesTreeModel>> _getCategories() async {
    final docs = await FirebaseFirestore.instance
        .collection(AppDBConstants.categoriesCollection)
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

  Future<List<UnitModel>> _getUnits() async {
    final docs = await FirebaseFirestore.instance
        .collection(AppDBConstants.unitsCollection)
        .get();
    final docsMap =
        Map.fromEntries(docs.docs.map((e) => MapEntry(e.id, e.data)));
    return docsMap.entries
        .map((e) => UnitModel.fromMap(e.key, e.value()))
        .toList();
  }

  Future<List<OrderTypeModel>> _getOrderTypes() async {
    final docs = await FirebaseFirestore.instance
        .collection(AppDBConstants.orderTypesCollection)
        .get();
    final docsMap =
        Map.fromEntries(docs.docs.map((e) => MapEntry(e.id, e.data())));
    return docsMap.entries
        .map((e) => OrderTypeModel.fromMap(e.key, e.value))
        .toList();
  }

  Stream<ProductModel> singleProduct(String uid) {
    return productsDb.streamSingle(uid);
  }

  Stream<List<SliderModel>> slidersStream() {
    return homeSliderDb.streamList();
  }

  Stream<List<ProductModel>> getProductsOnFlashSale() {
    List<QueryArgs> query = [
      QueryArgs(ProductModel.flashSaleUntilField),
    ];
    return productsDb.streamQueryList(args: query);
  }

  Stream<List<ProductModel>> getAllOtherProducts() {
    List<QueryArgs> query = [
      QueryArgs(ProductModel.isNewEntryField, isEqualTo: false),
    ];
    return productsDb.streamQueryList(args: query);
  }

  Stream<List<ProductModel>> getNewProducts() {
    List<QueryArgs> query = [
      QueryArgs(ProductModel.isNewEntryField, isEqualTo: true),
    ];
    return productsDb.streamQueryList(args: query);
  }

  Stream<List<ProductModel>> getRecommendedProducts() {
    List<QueryArgs> query = [
      QueryArgs(ProductModel.isRecommendedField, isEqualTo: true),
    ];
    return productsDb.streamQueryList(args: query);
  }
}
