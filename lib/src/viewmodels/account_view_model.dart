import 'package:bottleshopdeliveryapp/src/models/user.dart';
import 'package:bottleshopdeliveryapp/src/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/services/database/user_data_service.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class AccountViewModel extends BaseViewModel {
  AccountViewModel(Locator locator) : super(locator: locator);

  Future<User> getCurrentUser() async {
    return locator<Authentication>().currentUser();
  }

  Future<void> updateUserDetails(User newUserDetails) async {
    return locator<UserDataService>().setUser(newUserDetails);
  }
}
