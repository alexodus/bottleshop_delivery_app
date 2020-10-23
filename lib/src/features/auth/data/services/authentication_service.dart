import 'dart:io';

import 'package:bottleshopdeliveryapp/src/core/presentation/res/constants.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;

  AuthenticationService(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      FacebookLogin facebookLogin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(scopes: AppConstants.googleSignInScopes),
        _facebookLogin = facebookLogin ?? FacebookLogin();

  Future<UserModel> _signUserWithAuthCredential(
      AuthCredential credential) async {
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return UserModel.fromFirebaseUser(
        user: authResult.user, additionalData: authResult.additionalUserInfo);
  }

  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    return _signUserWithAuthCredential(credential);
  }

  Future<UserModel> createUserWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return UserModel.fromFirebaseUser(
        user: credential.user, additionalData: credential.additionalUserInfo);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserModel> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      return _signUserWithAuthCredential(credential);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<UserModel> signInWithFacebook() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    final result = await _facebookLogin.logIn(AppConstants.facebookPermissions);
    if (result.accessToken != null) {
      final credential =
          FacebookAuthProvider.credential(result.accessToken.token);
      return _signUserWithAuthCredential(credential);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<UserModel> signWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final credentialState =
        await SignInWithApple.getCredentialState(credential.userIdentifier);
    if (credentialState == CredentialState.authorized) {
      final authCredential = OAuthProvider('apple.com').credential(
          accessToken: credential.authorizationCode,
          idToken: credential.identityToken);
      return _signUserWithAuthCredential(authCredential);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<bool> supportsAppleSignIn() async {
    bool supportsAppleSignIn = false;
    if (Platform.isIOS) {
      supportsAppleSignIn = await SignInWithApple.isAvailable();
    }
    return supportsAppleSignIn;
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _googleSignIn.signOut(),
        _facebookLogin.logOut(),
        _firebaseAuth.signOut(),
      ]);
    } catch (e) {
      //
    }
  }

  Future<UserModel> signInAnonymously() async {
    final credential = await _firebaseAuth.signInAnonymously();
    return UserModel.fromFirebaseUser(
        user: credential.user, additionalData: credential?.additionalUserInfo);
  }

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
}
