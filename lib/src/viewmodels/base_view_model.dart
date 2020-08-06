import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseViewModel extends ChangeNotifier {
  final Locator locator;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void setNotLoading() {
    _isLoading = false;
    notifyListeners();
  }

  BaseViewModel({@required this.locator});
}
