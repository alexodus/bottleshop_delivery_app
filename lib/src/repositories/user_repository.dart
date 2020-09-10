import 'dart:async';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestoreInstance;

  UserRepository({FirebaseFirestore firestore})
      : _firestoreInstance = firestore ?? FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUser(String uid) async {
    return _firestoreInstance
        .collection(Constants.usersCollection)
        .doc(uid)
        .get();
  }

  Future<void> setUser(User user) async {
    final userDocRef =
        _firestoreInstance.collection(Constants.usersCollection).doc(user.uid);
    return userDocRef.set(user.toMap(), SetOptions(merge: true));
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
