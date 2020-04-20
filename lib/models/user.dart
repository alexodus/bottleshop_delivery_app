import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class User {
  final String uid;
  User({@required this.uid}) : assert(uid != null);
  User.fromFirebaseUser(FirebaseUser user) : uid = user.uid;
}
