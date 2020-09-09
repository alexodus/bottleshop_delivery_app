import 'package:bottleshopdeliveryapp/src/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class CartViewModel extends BaseViewModel {
  List<ProductModel> _shoppingCartContent;

  CartViewModel(Locator locator) : super(locator: locator);

  List<ProductModel> get shoppingCart => _shoppingCartContent ?? [];
}
