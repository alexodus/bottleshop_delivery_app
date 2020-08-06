import 'package:bottleshopdeliveryapp/src/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class ResetPasswordViewModel extends BaseViewModel {
  ResetPasswordViewModel(Locator locator) : super(locator: locator);

  Future<void> sendResetPasswordEmail(String email) async {
    setLoading();
    await locator<Authentication>().sendPasswordResetEmail(email);
    setNotLoading();
  }
}
