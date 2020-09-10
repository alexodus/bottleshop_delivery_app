import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/repositories/user_repository.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService implements Authentication {
  final auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;
  final UserRepository _userDataService;

  AuthenticationService(
      {auth.FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      FacebookLogin facebookLogin,
      UserRepository userDataService})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _googleSignIn =
            googleSignIn ?? GoogleSignIn(scopes: Constants.googleSignInScopes),
        _facebookLogin = facebookLogin ?? FacebookLogin(),
        _userDataService = userDataService ?? UserRepository();

  User _userFromFirebase(auth.User user,
      [auth.AdditionalUserInfo additionalData]) {
    if (user == null) {
      return null;
    }
    var email;
    if (additionalData != null) {
      if (user.email == null && additionalData?.profile['email'] != null) {
        email = additionalData?.profile['email'];
      } else {
        email = user.email;
      }
    }

    return User(
        uid: user.uid,
        email: email,
        name: user.displayName,
        avatar: user.photoURL,
        phoneNumber: user.phoneNumber);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final credential = auth.EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    final user = _userFromFirebase(authResult.user);
    await _userDataService.setUser(user);
    return user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user =
        _userFromFirebase(authResult.user, authResult.additionalUserInfo);
    await _userDataService.setUser(user);
    return user;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = auth.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final authResult = await _firebaseAuth.signInWithCredential(credential);
      final user =
          _userFromFirebase(authResult.user, authResult.additionalUserInfo);
      await _userDataService.setUser(user);
      return user;
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    final result = await _facebookLogin.logIn(Constants.facebookPermissions);
    if (result.accessToken != null) {
      final credential =
          auth.FacebookAuthProvider.credential(result.accessToken.token);
      final authResult = await _firebaseAuth.signInWithCredential(credential);
      final user =
          _userFromFirebase(authResult.user, authResult.additionalUserInfo);
      await _userDataService.setUser(user);
      return user;
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> currentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      final user = _userFromFirebase(firebaseUser);
      final userSnapshot = await _userDataService.getUser(user.uid);
      if (userSnapshot.exists) {
        return User.fromMap(userSnapshot.data());
      } else {
        return user;
      }
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
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    final user = _userFromFirebase(authResult.user);
    await _userDataService.setUser(user);
    return user;
  }

  @override
  Stream<User> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }
}
