import 'dart:async';

import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/models/user_model.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/services/authentication_service.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/data/services/user_db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class UserRepository with ChangeNotifier {
  final AuthenticationService _auth;
  Logger _logger;
  String _error;
  bool _loading;
  AuthStatus _status;
  StreamSubscription _userListener;
  UserModel _user;
  User _fbUser;

  String get error => _error;

  AuthStatus get status => _status;

  UserModel get user => _user;

  bool get isLoading => _loading;

  UserRepository.instance(
    this._auth,
  ) {
    _loading = false;
    _error = '';
    _logger = createLogger(this.runtimeType.toString());
    _auth.authStateChanges.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User fbUser) async {
    _logger.d('authState: $fbUser');
    if (fbUser == null) {
      _status = AuthStatus.Unauthenticated;
      _user = null;
      _fbUser = null;
    } else {
      _fbUser = fbUser;
      await _saveUserRecord();
      _userListener = userDb.streamSingle(fbUser.uid).listen((user) {
        _logger.d('authState fs: $user');
        _user = user;
        _loading = false;
        notifyListeners();
      });
      _status = AuthStatus.Authenticated;
    }
    notifyListeners();
  }

  Future<void> _saveUserRecord() async {
    if (_fbUser == null) return;
    UserModel user = UserModel.fromFirebaseUser(user: _fbUser);
    _logger.d('userFromFB: ${user.toString()}');
    UserModel existing = await userDb.getSingle(user.uid);
    _logger.d('ser: $existing');
    if (existing == null) {
      await userDb.create(user.toMap(), id: _fbUser.uid);
      _user = user;
    } else {
      _logger.d('existiningUser: $existing');
      _user = existing;
    }
    _logger.d('savedUser: $_user');
    notifyListeners();
  }

  Future<bool> _signIn(Future<UserModel> Function() signInMethod) async {
    try {
      _error = '';
      _status = AuthStatus.Authenticating;
      _loading = true;
      notifyListeners();
      await signInMethod();
      _error = '';
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message;
      rethrow;
    } catch (e) {
      _logger.e('signIn failure $e');
      if (error.isEmpty) {
        _error = 'Unfortunately, there was an error';
      }
      _status = AuthStatus.Unauthenticated;
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> sendResetPasswordEmail(String email) async {
    try {
      _loading = true;
      notifyListeners();
      await _auth.sendPasswordResetEmail(email);
      _error = '';
      return true;
    } catch (e) {
      _error = e.messsage;
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    try {
      _error = '';
      _status = AuthStatus.Authenticating;
      _loading = true;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email, password);
      await _auth.signInWithEmailAndPassword(email, password);
      _error = '';
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message;
      rethrow;
    } catch (e) {
      _logger.e('signIn failure $e');
      if (error.isEmpty) {
        _error = 'Unfortunately, there was an error';
      }
      _status = AuthStatus.Unauthenticated;
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    var result =
        await _signIn(() => _auth.signInWithEmailAndPassword(email, password));
    return result;
  }

  Future<bool> signUpWithGoogle() async {
    var result = await _signIn(_auth.signInWithGoogle);
    return result;
  }

  Future<bool> signUpWithFacebook() async {
    var result = await _signIn(_auth.signInWithFacebook);
    return result;
  }

  Future<bool> signUpAnonymously() async {
    var result = await _signIn(_auth.signInAnonymously);
    return result;
  }

  Future<bool> signUpWithApple() async {
    var result = await _signIn(_auth.signWithApple);
    return result;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _status = AuthStatus.Unauthenticated;
    _fbUser = null;
    _user = null;
    _userListener.cancel();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  @override
  void dispose() {
    _logger.d('authState: disposed');
    _userListener.cancel();
    super.dispose();
  }
}
