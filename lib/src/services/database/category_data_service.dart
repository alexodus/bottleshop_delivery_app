import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryDataService {
  final FirebaseFirestore _firestoreInstance;

  CategoryDataService() : _firestoreInstance = FirebaseFirestore.instance;

  Future<List<Category>> getAllCategories() async {
    var categorySnapShot = await _firestoreInstance
        .collection(Constants.categoriesCollection)
        .orderBy('name')
        .get();
    return categorySnapShot.docs
        .map((snapshot) => Category.fromMap(snapshot.data(), snapshot.id))
        .toList();
  }
}
