import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/base_view_model.dart';
import 'package:flutter/material.dart';

class SignInViewModel extends BaseViewModel {
  SignInViewModel({@required BuildContext context}) : super(context: context);

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      loading = true;
      User user =
          await authentication.signInWithEmailAndPassword(email, password);
      if (user != null) {
        await analytics.logLogin('email');
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('error: $e');
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      loading = true;
      User user = await authentication.signInWithGoogle();
      if (user != null) {
        await analytics.logLogin('google');
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      loading = true;
      User user = await authentication.signInWithFacebook();
      if (user != null) {
        await analytics.logLogin('facebook');
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
