import 'package:bottleshopdeliveryapp/src/core/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService implements Authentication {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;
  final Firestore _firestoreInstance;

  AuthenticationService(
      {FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn, FacebookLogin facebookLogin, Firestore firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _facebookLogin = facebookLogin ?? FacebookLogin(),
        _firestoreInstance = firestore ?? Firestore.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email,
      name: user.displayName,
      avatar: user.photoUrl,
    );
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final credential = EmailAuthProvider.getCredential(
      email: email,
      password: password,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    final user = _userFromFirebase(authResult.user);
    await _firestoreInstance.collection('users').document(user.uid).setData(user.toJson(), merge: true);
    return user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final user = _userFromFirebase(authResult.user);
    await _firestoreInstance.collection('users').document(user.uid).setData(user.toJson(), merge: true);
    return user;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final authResult = await _firebaseAuth.signInWithCredential(credential);
      final user = _userFromFirebase(authResult.user);
      await _firestoreInstance.collection('users').document(user.uid).setData(user.toJson(), merge: true);
      return user;
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final result = await _facebookLogin.logIn(Constants.facebookPermissions);
    if (result.accessToken != null) {
      final credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
      final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
      final user = _userFromFirebase(authResult.user);
      await _firestoreInstance.collection('users').document(user.uid).setData(user.toJson(), merge: true);
      return user;
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> currentUser() async {
    final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser != null) {
      final user = _userFromFirebase(firebaseUser);
      final userSnapshot = await _firestoreInstance.collection('users').document(user.uid).get();
      if (userSnapshot.exists) {
        return User.fromMap(userSnapshot.data);
      } else {
        return user;
      }
    } else {
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    var user = await currentUser();
    return user != null;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _facebookLogin.logOut();
    return _firebaseAuth.signOut();
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    final user = _userFromFirebase(authResult.user);
    await _firestoreInstance.collection('users').document(user.uid).setData(user.toJson(), merge: true);
    return user;
  }
}
