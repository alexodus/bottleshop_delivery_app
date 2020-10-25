import 'package:bottleshopdeliveryapp/src/core/data/res/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/database_service.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/models/device_model.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DatabaseService<UserModel> userDb = DatabaseService<UserModel>(
  AppDBConstants.usersCollection,
  toMap: (user) => user.toMap(),
  fromMap: (id, data) => UserModel.fromMap(id, data),
);

UserDeviceDBService userDeviceDb = UserDeviceDBService('devices');

class UserDeviceDBService extends DatabaseService<Device> {
  String collection;

  UserDeviceDBService(this.collection)
      : super(collection,
            fromMap: (id, data) => Device.fromMap(id, data),
            toMap: (device) => device.toMap());

  Stream<List<Device>> getAllModels() {
    return FirebaseFirestore.instance
        .collectionGroup(collection)
        .snapshots()
        .map((list) =>
            list.docs.map((doc) => fromMap(doc.id, doc.data())).toList());
  }
}
