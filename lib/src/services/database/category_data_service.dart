import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryDataService {
  final Firestore _firestoreInstance;

  CategoryDataService() : _firestoreInstance = Firestore.instance;

  Future<List<Category>> getAllCategories() async {
    var categorySnapShot =
        await _firestoreInstance.collection(Constants.categoriesCollection).orderBy('name').getDocuments();
    return categorySnapShot.documents.map((snapshot) => Category.fromMap(snapshot.data, snapshot.documentID)).toList();
  }
}
