import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class Authentication {
  Future<User> currentUser();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> createUserWithEmailAndPassword(String email, String password);

  Future<void> sendPasswordResetEmail(String email);

  Future<User> signInWithGoogle();

  Future<User> signInWithFacebook();

  Future<void> signOut();

  Stream<User> get onAuthStateChanged;

  void dispose();
}

abstract class BaseAuthService {
  @protected
  FirebaseAuth firebaseAuthInstance;
}

// ignore: constant_identifier_names
enum AuthenticationStatus { LOGGED_IN, NOT_LOGGED_IN, NOT_DETERMINED }
