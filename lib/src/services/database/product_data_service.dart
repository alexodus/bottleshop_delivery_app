import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDataService {
  final Firestore _firestoreInstance;

  ProductDataService({Firestore firestore}) : _firestoreInstance = firestore ?? Firestore.instance;

  Stream<QuerySnapshot> getAllProducts() {
    return _firestoreInstance.collection(Constants.productsCollection).snapshots();
  }
}
