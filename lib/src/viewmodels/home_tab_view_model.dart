import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/models/slider.dart';
import 'package:bottleshopdeliveryapp/src/services/database/firestore_service.dart';
import 'package:bottleshopdeliveryapp/src/services/notifications/push_notification_service.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeTabViewModel extends BaseViewModel {
  HomeTabViewModel(Locator locator) : super(locator: locator) {
    init();
  }

  final List<Product> _flashSales = [];
  List<Product> _products = [];
  final List<Category> _categories = [];
  final List<SubCategory> _subCategories = [];
  final List<Slider> _sliderList = [];
  String _selectedCategoryId;
  int _currentSlider = 0;

  String get selectedCategory => _selectedCategoryId;
  List<Product> get products => _products;
  List<Category> get categories => _categories;
  List<SubCategory> get subCategories => _subCategories;
  List<Product> get flashSales => _flashSales;
  List<Slider> get sliders => _sliderList;
  int get currentSlider => _currentSlider;

  void init() {
    locator<PushNotificationService>()
        .initialise()
        .then((_) => debugPrint('fcm init OK'))
        .catchError((err) => debugPrint('fcm init failed $err'));
  }

  void setCurrentSlider(int index) => _currentSlider = index;

  void selectCategory(String id) {
    _selectedCategoryId = id;
    notifyListeners();
  }

  bool isCategorySelected(String id) {
    return selectedCategory == id;
  }

  void listenToProducts() {
    setLoading();
    locator<FirestoreService>().listenToProductsRealTime().listen((productData) {
      var updatedProducts = productData;
      if (updatedProducts != null && updatedProducts.isNotEmpty) {
        _products = updatedProducts;
        notifyListeners();
      }
      setNotLoading();
    });
  }

  void requestMoreData() => locator<FirestoreService>().requestMoreData();
}
