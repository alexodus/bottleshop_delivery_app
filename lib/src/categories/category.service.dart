import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  final Firestore _firestoreInstance;
  CollectionReference _categoriesRef;
  CategoryService() : _firestoreInstance = Firestore.instance {
    _categoriesRef =
        _firestoreInstance.collection(Constants.categoriesCollection);
  }

  Future<List<Category>> getAllCategories() async {
    var categorySnapShot = await _categoriesRef.orderBy('name').getDocuments();
    return categorySnapShot.documents
        .map((snapshot) => Category.fromMap(snapshot.data, snapshot.documentID))
        .toList();
  }
}
