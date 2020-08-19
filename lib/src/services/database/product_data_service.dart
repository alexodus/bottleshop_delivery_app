import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDataService {
  final Firestore _firestoreInstance;

  ProductDataService({Firestore firestore})
      : _firestoreInstance = firestore ?? Firestore.instance;

  Stream<QuerySnapshot> getAllProductsStream() {
    return _firestoreInstance
        .collection(Constants.productsCollection)
        .orderBy('name')
        .snapshots();
  }

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
