import 'dart:collection';

import 'package:bottleshopdeliveryapp/src/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/database/product_data_service.dart';

class CategoryListModel {
  final _logger = Analytics.getLogger('CategoriesViewModel');
  final ProductDataService _categoryService;

  List<CategoriesTreeModel> _categoryTree = [];
  final List<String> _categoryFilters = [];
  final List<String> _subCategoryFilters = [];
  final List<String> _additionalCategoryFilters = [];
  static bool _isInitComplete = false;

  CategoryListModel({ProductDataService productDataService})
      : _categoryService = productDataService ?? ProductDataService();

  Future<void> fetchAllCategories() async {
    _logger.d('fetchAllCategories invoked');
    if (!_isInitComplete) {
      _isInitComplete = true;
      var categories = await _categoryService.categories();
      _categoryTree = [...categories];
      _categoryTree.sort((first, second) {
        if (first.subCategories.isEmpty && second.subCategories.isNotEmpty) {
          return 1;
        }
        if (first.subCategories.isNotEmpty && second.subCategories.isEmpty) {
          return -1;
        }
        return 0;
      });
      categories.forEach((element) => _logger.d(element));
    }
    _logger.d('fetchAllCategories fetch OK: $_isInitComplete');
  }

  CategoryListModel get instance => CategoryListModel();

  UnmodifiableListView<CategoriesTreeModel> get categories =>
      UnmodifiableListView(_categoryTree);

  CategoriesTreeModel getCategoryByName(String name) {
    var index = _categoryTree
        .indexWhere((element) => element.categoryDetails.name == name);
    return index < 0 ? null : _categoryTree.elementAt(index);
  }

  bool isSubCategorySelected(String subCategoryName) {
    return _subCategoryFilters.contains(subCategoryName);
  }

  bool isCategorySelected(String categoryName) {
    return _categoryFilters.contains(categoryName);
  }

  void toggleSubCategorySelection(String name) {
    if (_subCategoryFilters.contains(name)) {
      _subCategoryFilters.remove(name);
      if (getCategoryByName(name)?.subCategories != null) {
        getCategoryByName(name).subCategories
          ..map((subCategory) => subCategory.categoryDetails.name)
          ..forEach((name) => _subCategoryFilters.remove(name));
      }
    } else {
      _categoryFilters.add(name);
    }
  }

  void toggleCategorySelection(String name) {
    if (_categoryFilters.contains(name)) {
      _categoryFilters.remove(name);
      if (getCategoryByName(name)?.subCategories != null) {
        getCategoryByName(name).subCategories
          ..map((subCategory) => subCategory.categoryDetails.name)
          ..forEach((name) => _subCategoryFilters.remove(name));
      }
    } else {
      _categoryFilters.add(name);
    }
  }

  void clearAllSelection() {
    _additionalCategoryFilters.clear();
    _subCategoryFilters.clear();
    _categoryFilters.clear();
  }
}
