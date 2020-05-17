import 'package:bottleshopdeliveryapp/src/core/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService implements Authentication {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FacebookLogin facebookLogin;

  AuthenticationService(
      {@required this.firebaseAuth,
      @required this.googleSignIn,
      @required this.facebookLogin})
      : assert(firebaseAuth != null),
        assert(googleSignIn != null),
        assert(facebookLogin != null);

  factory AuthenticationService.fromDefault() {
    return AuthenticationService(
        firebaseAuth: FirebaseAuth.instance,
        googleSignIn: GoogleSignIn(),
        facebookLogin: FacebookLogin());
  }

  @override
  Stream<User> get onAuthStateChanged {
    return firebaseAuth.onAuthStateChanged
        .map((user) => User.fromFirebase(user));
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final authResult =
        await firebaseAuth.signInWithCredential(EmailAuthProvider.getCredential(
      email: email,
      password: password,
    ));
    return User.fromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return User.fromFirebase(authResult.user);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await firebaseAuth
            .signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return User.fromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final result = await facebookLogin.logIn(Constants.facebookPermissions);
    if (result.accessToken != null) {
      final AuthResult authResult = await firebaseAuth.signInWithCredential(
          FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token));
      return User.fromFirebase(authResult.user);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> currentUser() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    if (user != null) {
      return User.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await facebookLogin.logOut();
    await firebaseAuth.signOut();
  }

  @override
  void dispose() {}

  @override
  Future<User> signInAnonymously() async {
    final authResult = await firebaseAuth.signInAnonymously();
    return User.fromFirebase(authResult.user);
  }
}
