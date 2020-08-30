import 'package:bottleshopdeliveryapp/src/models/user.dart';

abstract class Authentication {
  Future<User> currentUser();

  Future<User> signInAnonymously();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> createUserWithEmailAndPassword(String email, String password);

  Future<void> sendPasswordResetEmail(String email);

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<void> signOut();

  Stream<User> get authStateChanges;
}
