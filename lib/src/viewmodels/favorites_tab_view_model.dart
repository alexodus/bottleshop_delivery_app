import 'package:bottleshopdeliveryapp/src/models/layout.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class FavoritesTabViewModel extends BaseViewModel {
  List<Product> _favorites = [];
  LayoutMode _layoutMode = LayoutMode.list;

  FavoritesTabViewModel(Locator locator) : super(locator: locator);

  List<Product> get favorites => _favorites;
  LayoutMode get layoutMode => _layoutMode;
  void setLayoutMode(LayoutMode newLayoutMode) {
    _layoutMode = newLayoutMode;
  }

  void addProductToFavorites(Product product) {
    setLoading();
    if (_favorites.contains(product)) {
      _favorites.add(product);
    }
    setNotLoading();
  }

  void removeProductFromFavorites(int index) {
    setLoading();
    _favorites.removeAt(index);
    setNotLoading();
  }
}
