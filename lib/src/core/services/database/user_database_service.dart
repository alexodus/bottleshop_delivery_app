import 'package:bottleshopdeliveryapp/src/core/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/services/database/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDatabaseService implements Database<User> {
  final Firestore firestore;
  UserDatabaseService({@required this.firestore}) : assert(firestore != null);

  factory UserDatabaseService.fromFireStore() {
    return UserDatabaseService(firestore: Firestore.instance);
  }

  @override
  Future<void> delete(User data) async {
    await firestore
        .document('${Constants.usersCollection}${data.uid}')
        .delete();
  }

  @override
  Future<void> save(User data) async {
    await update(data.uid, data);
  }

  @override
  Stream<User> stream(String uid) {
    return firestore
        .document('/users/$uid')
        .snapshots()
        .map((snapshot) => User.fromMap(snapshot.data));
  }

  @override
  Future<void> update(String uid, User user) async {
    await firestore.document('/users/$uid').setData(user.toJson(), merge: true);
  }
}
