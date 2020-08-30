import 'dart:async';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestoreInstance;

  FirestoreService({FirebaseFirestore firestore})
      : _firestoreInstance = firestore ?? FirebaseFirestore.instance;
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
      if (productSnapshot.docs.isNotEmpty) {
        var products = productSnapshot.docs
            .map((snapshot) => Product.fromMap(snapshot.data(), snapshot.id))
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
          _lastDocument = productSnapshot.docs.last;
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
        .get();
    return productDocuments.docs.map((product) {
      return Product.fromMap(product.data(), product.id);
    }).toList();
  }

  Future<List<Product>> getAllProductsByCategoryName(
      String categoryName) async {
    var productDocuments = await _firestoreInstance
        .collection(Constants.productsCollection)
        .where('category', isEqualTo: categoryName)
        .orderBy('name')
        .get();
    return productDocuments.docs.map((product) {
      return Product.fromMap(product.data(), product.id);
    }).toList();
  }

  Future<List<Product>> getAllProductsOnFlashSale() async {
    var productDocuments = await _firestoreInstance
        .collection(Constants.productsCollection)
        .orderBy('flash_sale_until')
        .get();
    return productDocuments.docs.map((product) {
      return Product.fromMap(product.data(), product.id);
    }).toList();
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
}
