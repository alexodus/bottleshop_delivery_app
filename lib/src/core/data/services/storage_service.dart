import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage;
  StorageService({FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> getDownloadURL(String filePath) async {
    String downloadURL;
    try {
      downloadURL = await _firebaseStorage.ref(filePath).getDownloadURL();
      return downloadURL;
    } catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
