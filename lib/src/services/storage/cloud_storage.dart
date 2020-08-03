import 'package:flutter/foundation.dart';

abstract class CloudStorage {
  Future<String> getDownloadUrl({@required String fileName, String folder = 'warehouse'});
}
