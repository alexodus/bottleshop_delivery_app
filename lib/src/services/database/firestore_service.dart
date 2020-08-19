import 'dart:async';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _logger = Analytics.getLogger('FirestoreService');
  final Firestore _firestoreInstance;

  FirestoreService({Firestore firestore})
      : _firestoreInstance = firestore ?? Firestore.instance;
  final StreamController<List<Product>> _productController =
      StreamController<List<Product>>.broadcast();

  final List<List<Product>> _allPagedResults = <List<Product>>[];

  static const int pageLimit = 20;

  DocumentSnapshot _lastDocument;
  bool _hasMoreProducts = true;

  void _requestProducts() {
    var pageProductQuery = _firestoreInstance
        .collection('warehouse')
        .orderBy('name')
          ..limit(pageLimit);
    if (_lastDocument != null) {
      pageProductQuery = pageProductQuery.startAfterDocument(_lastDocument);
    }
    if (!_hasMoreProducts) return;
    var currentRequestIndex = _allPagedResults.length;
    pageProductQuery.snapshots().listen((productSnapshot) {
      if (productSnapshot.documents.isNotEmpty) {
        var products = productSnapshot.documents
            .map((snapshot) =>
                Product.fromMap(snapshot.data, snapshot.documentID))
            .toList();
        var pageExists = currentRequestIndex < _allPagedResults.length;
        if (pageExists) {
          _allPagedResults[currentRequestIndex] = products;
        } else {
          _allPagedResults.add(products);
        }
        var allPosts = _allPagedResults.fold<List<Product>>(<Product>[],
            (initialValue, pageItems) => initialValue..addAll(pageItems));
        _productController.add(allPosts);
        if (currentRequestIndex == _allPagedResults.length - 1) {
          _lastDocument = productSnapshot.documents.last;
        }
        _hasMoreProducts = products.length == pageLimit;
      }
    });
  }

  Stream<List<Product>> listenToProductsRealTime() {
    _requestProducts();
    return _productController.stream;
  }

  void requestMoreData() => _requestProducts();

  Future<List<Product>> getAllProducts() async {
    var productDocuments = await _firestoreInstance
        .collection(Constants.productsCollection)
        .orderBy('name')
        .getDocuments();
    return productDocuments.documents.map((product) {
      return Product.fromMap(product.data, product.documentID);
    }).toList();
  }

  Future<List<Product>> getAllProductsByCategoryName(
      String categoryName) async {
    var productDocuments = await _firestoreInstance
        .collection(Constants.productsCollection)
        .where('category', isEqualTo: categoryName)
        .orderBy('name')
        .getDocuments();
    return productDocuments.documents.map((product) {
      return Product.fromMap(product.data, product.documentID);
    }).toList();
  }

  Future<List<Product>> getAllProductsOnFlashSale() async {
    var productDocuments = await _firestoreInstance
        .collection(Constants.productsCollection)
        .orderBy('flash_sale_until')
        .getDocuments();
    return productDocuments.documents.map((product) {
      return Product.fromMap(product.data, product.documentID);
    }).toList();
  }

  Future<List<SliderModel>> getSlidersConfig() async {
    var slidersDocument = await _firestoreInstance
        .collection(Constants.configurationCollection)
        .document('0')
        .get();
    List<SliderModel> sliders;
    if (slidersDocument.data['sliders'] != null) {
      var slidersData = slidersDocument.data['sliders'];
      sliders = <SliderModel>[];
      slidersData.forEach((data) => sliders.add(SliderModel.fromMap(data)));
    }
    return sliders;
  }
}
