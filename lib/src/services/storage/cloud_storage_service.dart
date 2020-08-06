import 'package:bottleshopdeliveryapp/src/services/storage/cloud_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class CloudStorageService implements CloudStorage {
  final FirebaseStorage _storageInstance;

  CloudStorageService({
    FirebaseStorage firebaseStorage,
  }) : _storageInstance = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> getDownloadUrl(
      {@required String fileName, String folder = 'warehouse'}) async {
    final StorageReference reference = _storageInstance.ref();
    return reference.child('/$folder/$fileName').getDownloadURL();
  }
}
