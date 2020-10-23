import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:bottleshopdeliveryapp/src/features/home/data/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/categories_tree_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/repositories/product_repository.dart';
import 'package:hooks_riverpod/all.dart';

final homeSliderProvider = StreamProvider.autoDispose<List<SliderModel>>(
    (ref) => ref.watch(productRepositoryProvider).slidersStream());

final productRepositoryProvider =
    ChangeNotifierProvider<ProductRepository>((ref) {
  return ProductRepository.instance();
});

final newProductsProvider =
    StreamProvider.autoDispose<List<ProductModel>>((ref) {
  final state = ref.watch(productRepositoryProvider).getNewProducts();
  return state;
});

final recommendedProductsProvider =
    StreamProvider.autoDispose<List<ProductModel>>((ref) {
  final state = ref.watch(productRepositoryProvider).getRecommendedProducts();
  return state;
});

final otherProductsProvider =
    StreamProvider.autoDispose<List<ProductModel>>((ref) {
  final state = ref.watch(productRepositoryProvider).getAllOtherProducts();
  return state;
});

final flashSalesProvider =
    StreamProvider.autoDispose<List<ProductModel>>((ref) {
  final state = ref.watch(productRepositoryProvider).getProductsOnFlashSale();
  return state;
});

final categoriesProvider =
    FutureProvider.autoDispose<List<CategoriesTreeModel>>((ref) async {
  final state = await ref.watch(productRepositoryProvider).categories();
  return state;
});

class CategoryFilter extends StateNotifier<List<String>> {
  final _logger = createLogger('CategoryFilter');

  CategoryFilter() : super([]);

  void addCategory(String id) {
    _logger.d('adding $id');
    state = [
      id,
      ...state,
    ];
  }

  void removeCategory(String id) {
    state.removeWhere((element) => element == id);
    state = [...state];
  }

  bool isSelected(String id) {
    return state.contains(id);
  }

  void clearSelection() {
    state = [];
  }
}

final categoryFilterProvider = StateNotifierProvider((ref) => CategoryFilter());
