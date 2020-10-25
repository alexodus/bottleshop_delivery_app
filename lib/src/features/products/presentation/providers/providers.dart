import 'package:bottleshopdeliveryapp/src/features/home/data/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/category_plain_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/repositories/product_repository.dart';
import 'package:hooks_riverpod/all.dart';

final homeSliderProvider = StreamProvider.autoDispose<List<SliderModel>>((ref) {
  final sliders = ref.watch(productRepositoryProvider).slidersStream();
  return sliders;
});

final productRepositoryProvider =
    ChangeNotifierProvider<ProductRepository>((ref) {
  return ProductRepository.instance();
});

final selectedCategoriesProvider = Provider<SelectableCategory>((ref) =>
    ref
        .watch(productRepositoryProvider)
        .selectableCategories
        .firstWhere((element) => element.selected) ??
    []);

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
