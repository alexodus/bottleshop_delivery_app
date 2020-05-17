import 'package:bottleshopdeliveryapp/src/core/models/user.dart';
import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:bottleshopdeliveryapp/src/core/services/database/database.dart';
import 'package:bottleshopdeliveryapp/src/core/services/preferences/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class BaseViewModel extends ChangeNotifier {
  final BuildContext context;
  bool _isBusy = false;
  bool get isBusy => _isBusy;
  set loading(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  Authentication authentication;
  Database<User> userDatabase;
  Analytics analytics;
  UserPreferences userPreferences;

  BaseViewModel({@required this.context}) {
    authentication = Provider.of<Authentication>(context);
    userDatabase = Provider.of<Database<User>>(context);
    analytics = Provider.of<Analytics>(context);
    userPreferences = Provider.of<UserPreferences>(context);
  }
}
