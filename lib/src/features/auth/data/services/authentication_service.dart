import 'dart:io';

import 'package:bottleshopdeliveryapp/src/core/presentation/res/constants.dart';
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

  Future<void> _signUserWithAuthCredential(AuthCredential credential) async {
    await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await _signUserWithAuthCredential(credential);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<void> signInWithFacebook() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    final result = await _facebookLogin.logIn(AppConstants.facebookPermissions);
    if (result.accessToken != null) {
      final credential =
          FacebookAuthProvider.credential(result.accessToken.token);
      await _signUserWithAuthCredential(credential);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<void> signWithApple() async {
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
      await _signUserWithAuthCredential(authCredential);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<bool> get supportsAppleSignIn async {
    bool supportsAppleSignIn = false;
    if (Platform.isIOS) {
      supportsAppleSignIn = await SignInWithApple.isAvailable();
    }
    return supportsAppleSignIn;
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _facebookLogin.logOut(),
      ]);
    } catch (e) {
      //
    }
  }

  Future<void> signInAnonymously() async {
    await _firebaseAuth.signInAnonymously();
  }

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
}
