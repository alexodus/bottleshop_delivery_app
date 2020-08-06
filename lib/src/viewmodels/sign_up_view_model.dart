import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class SignUpViewModel extends BaseViewModel {
  SignUpViewModel(Locator locator) : super(locator: locator);

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    setLoading();
    await locator<Authentication>()
        .createUserWithEmailAndPassword(email, password);
    await locator<Authentication>().signInWithEmailAndPassword(email, password);
    await locator<Analytics>().logSignUp('email');
    setNotLoading();
  }

  Future<void> signUpWithGoogle() async {
    setLoading();
    await locator<Authentication>().signInWithGoogle();
    await locator<Analytics>().logSignUp('google');
    setNotLoading();
  }

  Future<void> signUpWithFacebook() async {
    setLoading();
    await locator<Authentication>().signInWithFacebook();
    await locator<Analytics>().logSignUp('facebook');
    setNotLoading();
  }

  Future<void> signUpAnonymously() async {
    setLoading();
    await locator<Authentication>().signInAnonymously();
    await locator<Analytics>().logSignUp('anonymously');
    setNotLoading();
  }
}
