import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesRepository {
  final _logger = Analytics.getLogger('CategoriesRepository');
  final FirebaseFirestore _firestoreInstance;

  CategoriesRepository({FirebaseFirestore firestore})
      : _firestoreInstance = firestore ?? FirebaseFirestore.instance;

  Future<void> getAllCategories() async {
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
