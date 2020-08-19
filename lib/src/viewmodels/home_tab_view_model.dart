import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/database/product_data_service.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class HomeTabViewModel extends BaseViewModel {
  final _logger = Analytics.getLogger('HomeTabViewModel');
  HomeTabViewModel(Locator locator) : super(locator: locator) {
    init()
        .then((value) => _logger.d('data fetched'))
        .catchError((error) => _logger.e('data fetch failed: $error'));
  }

  List<Product> _flashSales;
  List<Product> _products;
  List<SliderModel> _sliderList;
  int _currentSlider = 0;

  List<Product> get products => _products ?? [];

  List<Product> get flashSales => _flashSales ?? [];

  List<SliderModel> get sliders => _sliderList ?? [];

  int get currentSlider => _currentSlider;

  Future<void> init() async {
    setLoading();
    try {
      var fetchResult = await Future.wait([
        locator<ProductDataService>().getAllProducts(),
        locator<ProductDataService>().getSlidersConfig(),
        locator<ProductDataService>().getAllProductsOnFlashSale(),
      ]);
      _products = fetchResult[0];
      _sliderList = fetchResult[1];
      _flashSales = fetchResult[2];
    } catch (e) {
      _logger.e('failed fetching data: $e');
    } finally {
      setNotLoading();
    }
  }

  Future<void> getProductsBySelectedCategory() async {
    /*setLoading();
    _products = await locator<FirestoreService>().getAllProductsByCategoryName(super.selectedCategory);
    setNotLoading();*/
  }

  void setCurrentSlider(int index) {
    _currentSlider = index;
    notifyListeners();
  }
}
