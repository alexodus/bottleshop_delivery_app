import 'dart:collection';

import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/database/category_data_service.dart';

class CategoryListModel {
  static final CategoryListModel _instance = CategoryListModel?._internal();

  final _logger = Analytics.getLogger('CategoriesViewModel');
  final CategoryDataService _categoryService = CategoryDataService();
  final List<Category> _categories = [];
  final List<String> _categoryFilters = [];
  final List<String> _subCategoryFilters = [];
  final List<String> _additionalCategoryFilters = [];
  static bool _isInitComplete = false;

  CategoryListModel._internal();

  factory CategoryListModel() {
    return _instance;
  }

  Future<void> fetchAllCategories() async {
    _logger.d('fetchAllCategories invoked');
    if (!_isInitComplete) {
      var iterable = await _categoryService.getAllCategories();
      _categories.clear();
      _categories.addAll(iterable);
      _categories.forEach((element) => _logger.d('element: $element'));
      _isInitComplete = true;
    }
    _logger.d('fetchAllCategories fetch OK: $_isInitComplete');
  }

  CategoryListModel get instance => CategoryListModel();

  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);

  Category getCategoryByName(String name) {
    var index = _categories.indexWhere((element) => element.name == name);
    return index < 0 ? null : _categories[index];
  }

  SubCategory getSubCategoryByName(String name) {
    SubCategory subCategory;
    for (var category in categories) {
      if (category.subCategories != null) {
        var index = category.subCategories
            .indexWhere((subCategory) => subCategory.name == name);
        if (index >= 0) {
          subCategory = category.subCategories[index];
          break;
        } else {
          continue;
        }
      } else {
        return null;
      }
    }
    return subCategory;
  }

  bool isSubCategorySelected(String subCategoryName) {
    return _subCategoryFilters.contains(subCategoryName);
  }

  bool isCategorySelected(String categoryName) {
    return _categoryFilters.contains(categoryName);
  }

  void toggleAdditionalCategorySelection(String name) {
    _subCategoryFilters.firstWhere((element) => element == name);
  }

  void toggleSubCategorySelection(String name) {
    if (_subCategoryFilters.contains(name)) {
      _subCategoryFilters.remove(name);
      if (getCategoryByName(name)?.subCategories != null) {
        getCategoryByName(name).subCategories
          ..map((subCategory) => subCategory.name)
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
          ..map((subCategory) => subCategory.name)
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
