import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class SignInViewModel extends BaseViewModel {
  SignInViewModel(Locator locator) : super(locator: locator);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    setLoading();
    await locator<Authentication>().signInWithEmailAndPassword(email, password);
    await locator<Analytics>().logLogin('email');
    setNotLoading();
  }

  Future<void> signInWithGoogle() async {
    setLoading();
    await locator<Authentication>().signInWithGoogle();
    await locator<Analytics>().logLogin('google');
    setNotLoading();
  }

  Future<void> signInWithFacebook() async {
    setLoading();
    await locator<Authentication>().signInWithFacebook();
    await locator<Analytics>().logLogin('facebook');
    setNotLoading();
  }

  Future<void> signInAnonymously() async {
    setLoading();
    await locator<Authentication>().signInAnonymously();
    await locator<Analytics>().logSignUp('anonymously');
    setNotLoading();
  }
}
