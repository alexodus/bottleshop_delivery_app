import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/services/database/user_data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService implements Authentication {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookLogin _facebookLogin;
  final UserDataService _userDataService;

  AuthenticationService(
      {FirebaseAuth firebaseAuth,
      GoogleSignIn googleSignIn,
      FacebookLogin facebookLogin,
      UserDataService userDataService})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(scopes: Constants.googleSignInScopes),
        _facebookLogin = facebookLogin ?? FacebookLogin(),
        _userDataService = userDataService ?? UserDataService();

  User _userFromFirebase(FirebaseUser user, [AdditionalUserInfo additionalData]) {
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
        uid: user.uid, email: email, name: user.displayName, avatar: user.photoUrl, phoneNumber: user.phoneNumber);
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
    await _userDataService.setUser(user);
    return user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final user = _userFromFirebase(authResult.user, authResult.additionalUserInfo);
    await _userDataService.setUser(user);
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
      final user = _userFromFirebase(authResult.user, authResult.additionalUserInfo);
      await _userDataService.setUser(user);
      return user;
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.nativeWithFallback;
    final result = await _facebookLogin.logIn(Constants.facebookPermissions);
    if (result.accessToken != null) {
      final credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
      final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
      final user = _userFromFirebase(authResult.user, authResult.additionalUserInfo);
      await _userDataService.setUser(user);
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
      final userSnapshot = await _userDataService.getUser(user.uid);
      if (userSnapshot.exists) {
        return User.fromMap(userSnapshot.data);
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
}
