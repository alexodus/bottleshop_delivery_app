import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataService {
  final Firestore _firestoreInstance;

  UserDataService() : _firestoreInstance = Firestore.instance;

  Future<DocumentSnapshot> getUser(String uid) async {
    return _firestoreInstance
        .collection(Constants.usersCollection)
        .document(uid)
        .get();
  }

  Future<void> setUser(User user) async {
    return _firestoreInstance
        .collection(Constants.usersCollection)
        .document(user.uid)
        .setData(user.toJson(), merge: true);
  }
}
