import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication.dart';
import 'package:bottleshopdeliveryapp/src/services/log_engine_service.dart';
import 'package:bottleshopdeliveryapp/src/state/AppState.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class AuthState extends AppState {
  AuthenticationStatus authStatus = AuthenticationStatus.NOT_DETERMINED;
  User user;
  final Authentication authentication;
  Logger log = LogEngineService().getLogger('AuthState');

  AuthState({@required this.authentication}) : assert(authentication != null);

  Future<void> logoutCallback() async {
    log.d('signing out');
    loading = true;
    try {
      await authentication.signOut();
    } finally {
      authStatus = AuthenticationStatus.NOT_LOGGED_IN;
      user = null;
      loading = false;
      notifyListeners();
      log.d('user signed out');
    }
  }

  /// Alter select auth method, login and sign up page
  void openSignUpPage() {
    authStatus = AuthenticationStatus.NOT_LOGGED_IN;
    notifyListeners();
  }

  Future<void> handleSignIn(String email, String password) async {
    log.d('signing in with credentials');
    try {
      loading = true;
      user = await authentication.signInWithEmailAndPassword(email, password);
      authStatus = AuthenticationStatus.LOGGED_IN;
      log.d('signed in as $user');
    } catch (e) {
      log.e('sign in failed $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> handleGoogleSignIn() async {
    log.d('signing in with Google');
    try {
      loading = true;
      user = await authentication.signInWithGoogle();
      authStatus = AuthenticationStatus.LOGGED_IN;
      log.d('signed in as $user');
    } catch (e) {
      log.e('sign in failed $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> handleFacebookSignIn() async {
    log.d('signing in with Facebook');
    try {
      loading = true;
      user = await authentication.signInWithFacebook();
      authStatus = AuthenticationStatus.LOGGED_IN;
      log.d('signed in as $user');
    } catch (e) {
      log.e('sign in failed $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  /// Fetch current user profile
  Future<User> getCurrentUser() async {
    try {
      loading = true;
      user = await authentication.currentUser();
      if (user != null) {
        authStatus = AuthenticationStatus.LOGGED_IN;
      } else {
        authStatus = AuthenticationStatus.NOT_LOGGED_IN;
      }
      loading = false;
      return user;
    } catch (error) {
      loading = false;
      authStatus = AuthenticationStatus.NOT_LOGGED_IN;
      return null;
    }
  }
}
