import 'package:bottleshopdeliveryapp/src/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/database/product_data_service.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class HomeTabViewModel extends BaseViewModel {
  final _logger = Analytics.getLogger('HomeTabViewModel');
  HomeTabViewModel(Locator locator) : super(locator: locator) {
    _init()
        .then(
          (value) => _logger.d('data fetched'),
        )
        .catchError(
          (error) => _logger.e('data fetch failed: $error'),
        );
  }
  List<SliderModel> _sliderList;
  int _currentSlider = 0;

  Future<void> _init() async {
    setLoading();
    try {
      _sliderList = await locator<ProductDataService>().getSlidersConfig();
    } catch (e) {
      _logger.e('failed fetching data: $e');
    } finally {
      setNotLoading();
    }
  }

  Stream<QuerySnapshot> get products =>
      locator<ProductDataService>().getAllOtherProducts() ?? [];

  Stream<QuerySnapshot> get recommendedProducts =>
      locator<ProductDataService>().getRecommendedProducts() ?? [];

  Stream<QuerySnapshot> get newProducts =>
      locator<ProductDataService>().getNewProducts() ?? [];

  Stream<QuerySnapshot> get flashSaleProducts =>
      locator<ProductDataService>().getProductsOnFlashSale() ?? [];

  List<SliderModel> get sliders => _sliderList ?? [];

  int get currentSlider => _currentSlider;

  void setCurrentSlider(int index) {
    _currentSlider = index;
    notifyListeners();
  }

  Future<ProductModel> parseFromJson(Map<String, dynamic> productJson) async {
    return locator<ProductDataService>().parseProductJson(productJson);
  }
}
