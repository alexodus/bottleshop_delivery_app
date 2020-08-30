import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDataService {
  final FirebaseFirestore _firestoreInstance;

  ProductDataService({FirebaseFirestore firestore})
      : _firestoreInstance = firestore ?? FirebaseFirestore.instance;

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
