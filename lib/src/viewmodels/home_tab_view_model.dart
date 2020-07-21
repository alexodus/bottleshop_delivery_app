import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/services/database/firestore_service.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class HomeTabViewModel extends BaseViewModel {
  HomeTabViewModel(Locator locator) : super(locator: locator);

  List<Product> _flashSales = [];
  List<Product> _products;
  List<Category> _categories;
  List<SubCategory> _subCategories;
  String _selectedCategoryId;

  String get selectedCategory => _selectedCategoryId;
  List<Product> get products => _products;
  List<Category> get categories => _categories;
  List<SubCategory> get subCategories => _subCategories;
  List<Product> get flashSales => _flashSales;

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
      List<Product> updatedProducts = productData;
      if (updatedProducts != null && updatedProducts.isNotEmpty) {
        _products = updatedProducts;
        notifyListeners();
      }
      setNotLoading();
    });
  }

  void fetchCategories() => locator<FirestoreService>().requestCategories().then((value) => _categories = value);

  void requestMoreData() => locator<FirestoreService>().requestMoreData();
}
