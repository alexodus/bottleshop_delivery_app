import 'package:bottleshopdeliveryapp/src/core/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/core/services/authentication/authentication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  Analytics analytics;

  BaseViewModel({@required this.context}) {
    authentication = Provider.of<Authentication>(context);
    analytics = Provider.of<Analytics>(context);
  }
}
