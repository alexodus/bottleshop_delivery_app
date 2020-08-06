import 'dart:async';

import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final Firestore _firestoreInstance;

  FirestoreService({Firestore firestore})
      : _firestoreInstance = firestore ?? Firestore.instance;

  final StreamController<List<Product>> _productController =
      StreamController<List<Product>>.broadcast();

  List<List<Product>> _allPagedResults = List<List<Product>>();

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
        var allPosts = _allPagedResults.fold<List<Product>>(List<Product>(),
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
}
