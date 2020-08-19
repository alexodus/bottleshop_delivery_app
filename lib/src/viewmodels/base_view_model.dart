import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseViewModel extends ChangeNotifier {
  final _logger = Analytics.getLogger('BaseViewModel');
  bool _isLoading = false;
  final Locator locator;

  BaseViewModel({@required this.locator}) : super() {
    _logger.d('BaseViewModel spawned');
  }

  void setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void setNotLoading() {
    _isLoading = false;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
