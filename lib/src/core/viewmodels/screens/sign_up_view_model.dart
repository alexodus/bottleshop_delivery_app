import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/base_view_model.dart';
import 'package:flutter/cupertino.dart';

class SignUpViewModel extends BaseViewModel {
  SignUpViewModel({@required BuildContext context}) : super(context: context);

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    try {
      loading = true;
      User user =
          await authentication.createUserWithEmailAndPassword(email, password);
      if (user != null) {
        await userDatabase.save(user);
        await analytics.logSignUp('email');
        await authentication.signInWithEmailAndPassword(email, password);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('err: $e');
      return false;
    }
  }

  Future<bool> signUpWithGoogle() async {
    try {
      loading = true;
      User user = await authentication.signInWithGoogle();
      if (user != null) {
        await userDatabase.save(user);
        await analytics.logSignUp('google');
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('err: $e');
      return false;
    }
  }

  Future<bool> signUpWithFacebook() async {
    try {
      loading = true;
      User user = await authentication.signInWithFacebook();
      if (user != null) {
        await userDatabase.save(user);
        await analytics.logSignUp('facebook');
        return true;
      }
      return false;
    } catch (e) {
      print('err: $e');
      return false;
    }
  }

  @override
  void dispose() {
    print('signUpViewModel dispose');
    super.dispose();
  }
}
