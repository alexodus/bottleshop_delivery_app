import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/database/firestore_service.dart';
import 'package:bottleshopdeliveryapp/src/services/notifications/push_notification_service.dart';
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
  List<Category> _categories;
  List<SliderModel> _sliderList;
  String _selectedCategoryId;
  int _currentSlider = 0;

  String get selectedCategory => _selectedCategoryId;
  List<Product> get products => _products ?? [];
  List<Category> get categories => _categories ?? [];
  List<Product> get flashSales => _flashSales ?? [];
  List<SliderModel> get sliders => _sliderList ?? [];
  int get currentSlider => _currentSlider;

  Future<void> init() async {
    setLoading();
    await locator<PushNotificationService>().initialise();
    _categories = await locator<FirestoreService>().getAllCategories();
    _products = await locator<FirestoreService>().getAllProducts();
    _sliderList = await locator<FirestoreService>().getSlidersConfig();
    _flashSales = await locator<FirestoreService>().getAllProductsOnFlashSale();
    setNotLoading();
  }

  void setCurrentSlider(int index) {
    _currentSlider = index;
    _logger.d('currentSliderIndex: $_currentSlider');
  }

  void selectCategory(String id) {
    _selectedCategoryId = id;
    notifyListeners();
  }

  bool isCategorySelected(String id) {
    return selectedCategory == id;
  }
}
