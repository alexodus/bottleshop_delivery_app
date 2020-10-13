import 'dart:io';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/repositories/user_repository.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AuthState {
  LOGGED_IN,
  LOGGED_OUT,
}

class AuthenticationService implements Authentication {
  static AuthenticationService _instance;
  final auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;
  final UserRepository _userRepository;

  AuthenticationService._internal(
      {auth.FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      FacebookLogin facebookLogin,
      UserRepository userRepository})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _googleSignIn =
            googleSignIn ?? GoogleSignIn(scopes: Constants.googleSignInScopes),
        _facebookLogin = facebookLogin ?? FacebookLogin(),
        _userRepository = userRepository ?? UserRepository();

  factory AuthenticationService() {
    return _instance ?? AuthenticationService._internal();
  }

  Future<void> _signUserWithAuthCredential(
      auth.AuthCredential credential) async {
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    final user = User.fromFirebase(
        user: authResult.user, additionalData: authResult.additionalUserInfo);
    await _userRepository.setUser(user);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final credential = auth.EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await _signUserWithAuthCredential(credential);
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = User.fromFirebase(
        user: credential.user, additionalData: credential.additionalUserInfo);
    await _userRepository.setUser(user);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = auth.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await _signUserWithAuthCredential(credential);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<void> signInWithFacebook() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    final result = await _facebookLogin.logIn(Constants.facebookPermissions);
    if (result.accessToken != null) {
      final credential =
          auth.FacebookAuthProvider.credential(result.accessToken.token);
      await _signUserWithAuthCredential(credential);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<void> signWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final credentialState =
        await SignInWithApple.getCredentialState(credential.userIdentifier);
    switch (credentialState) {
      case CredentialState.authorized:
        final authCredential = auth.OAuthProvider('apple.com').credential(
            accessToken: credential.authorizationCode,
            idToken: credential.identityToken);
        await _firebaseAuth.signInWithCredential(authCredential);
        break;
      case CredentialState.revoked:
      case CredentialState.notFound:
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
        break;
    }
  }

  Future<bool> supportsAppleSignIn() async {
    bool supportsAppleSignIn = false;
    if (Platform.isIOS) {
      supportsAppleSignIn = await SignInWithApple.isAvailable();
    }
    return supportsAppleSignIn;
  }

  @override
  Future<User> currentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      final user = await _userRepository.getUser(firebaseUser.uid);
      return user ?? User.fromFirebase(user: firebaseUser);
    } else {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _facebookLogin.logOut();
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> signInAnonymously() async {
    final credential = await _firebaseAuth.signInAnonymously();
    final user = User.fromFirebase(
        user: credential.user, additionalData: credential.additionalUserInfo);
    await _userRepository.setUser(user);
  }

  @override
  Stream<User> get authStateChanges {
    return _firebaseAuth
        .authStateChanges()
        .map((firebaseUser) => User.fromFirebase(user: firebaseUser));
  }
}
