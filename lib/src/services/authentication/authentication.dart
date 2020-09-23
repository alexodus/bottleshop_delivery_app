import 'package:bottleshopdeliveryapp/src/models/user.dart';

abstract class Authentication {
  Future<User> currentUser();

  Future<void> signInAnonymously();

  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> createUserWithEmailAndPassword(String email, String password);

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signInWithGoogle();

  Future<void> signInWithFacebook();

  Future<void> signWithApple();

  Future<void> signOut();

  Stream<User> get authStateChanges;
}
