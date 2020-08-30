import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/category_list_model.dart';
import 'package:provider/provider.dart';

class CategoriesViewModel extends BaseViewModel {
  final _logger = Analytics.getLogger('CategoriesViewModel');
  CategoryListModel _categoryListModelInstance;

  CategoriesViewModel(Locator locator)
      : _categoryListModelInstance = locator<CategoryListModel>().instance,
        super(locator: locator) {
    init().then((value) => _logger.i('CategoryList fetch OK'));
  }

  Future<void> init() async {
    setLoading();
    try {
      await _categoryListModelInstance.fetchAllCategories();
    } catch (e) {
      _logger.e('failed fetching data: $e');
    } finally {
      setNotLoading();
    }
  }

  CategoriesViewModel updateCategoryListModel(CategoryListModel listModel) {
    setLoading();
    _categoryListModelInstance = listModel.instance;
    setNotLoading();
    return this;
  }
}
