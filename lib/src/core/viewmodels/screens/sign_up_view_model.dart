import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SignUpViewModel extends ChangeNotifier {
  final Locator locator;

  SignUpViewModel(this.locator);

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

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    _setLoading();
    await locator<Authentication>().createUserWithEmailAndPassword(email, password);
    await locator<Authentication>().signInWithEmailAndPassword(email, password);
    await locator<Analytics>().logSignUp('email');
    _setNotLoading();
  }

  Future<void> signUpWithGoogle() async {
    _setLoading();
    await locator<Authentication>().signInWithGoogle();
    await locator<Analytics>().logSignUp('google');
    _setNotLoading();
  }

  Future<void> signUpWithFacebook() async {
    _setLoading();
    await locator<Authentication>().signInWithFacebook();
    await locator<Analytics>().logSignUp('facebook');
    _setNotLoading();
  }
}
