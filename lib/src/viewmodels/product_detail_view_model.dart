import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/database/user_data_service.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class ProductDetailViewModel extends BaseViewModel {
  final _logger = Analytics.getLogger('ProductDetailView');
  final _cartModel = <String, int>{};

  ProductDetailViewModel(Locator locator) : super(locator: locator);

  Future<void> toggleWishList(String productId) async {
    setLoading();
    if (isProductInFavorites(productId)) {
      _logger.d('removed $productId from favourites');
      await locator<UserDataService>()
          .removeProductFromWishList('/warehouse/$productId');
    } else {
      _logger.d('added $productId to favourites');
      await locator<UserDataService>()
          .addProductToWishList('/warehouse/$productId');
    }
    setNotLoading();
  }

  bool isProductInFavorites(String productId) =>
      locator<UserDataService>().isProductInWishList('/warehouse/$productId');

  bool isProductInCart(String productId) =>
      locator<UserDataService>().isProductInCart('/warehouse/$productId');

  int getTotalCountInCart() => _cartModel.values
      .fold<int>(0, (previousValue, element) => previousValue += element);

  Future<void> addToCart(String productId) async {
    _logger.d('added $productId to cart');
    _cartModel.update('/warehouse/$productId', (value) => ++value,
        ifAbsent: () => 1);
    notifyListeners();
  }

  Future<void> removeFromCart(String productId) async {
    _logger.d('removed $productId from cart');
    _cartModel['/warehouse/$productId'] > 1
        ? _cartModel.update(productId, (value) => --value)
        : _cartModel.remove(productId);
    notifyListeners();
  }
}
