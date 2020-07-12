import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInViewModel extends ChangeNotifier {
  SignInViewModel(this.locator);

  final Locator locator;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _setNotLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _setLoading();
    await locator<Authentication>().signInWithEmailAndPassword(email, password);
    await locator<Analytics>().logLogin('email');
    _setNotLoading();
  }

  Future<void> signInWithGoogle() async {
    _setLoading();
    await locator<Authentication>().signInWithGoogle();
    await locator<Analytics>().logLogin('google');
    _setNotLoading();
  }

  Future<void> signInWithFacebook() async {
    _setLoading();
    await locator<Authentication>().signInWithFacebook();
    await locator<Analytics>().logLogin('facebook');
    _setNotLoading();
  }
}
