import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class CartViewModel extends BaseViewModel {
  List<Product> _shoppingCartContent;

  CartViewModel(Locator locator) : super(locator: locator);

  List<Product> get shoppingCart => _shoppingCartContent ?? [];
}
