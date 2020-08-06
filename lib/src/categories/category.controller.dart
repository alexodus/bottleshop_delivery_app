import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/services/database/category_data_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController to = Get.find();
  final _categoryDataService = CategoryDataService();

  RxList<Category> categoryList;

  @override
  void onReady() {
    _categoryDataService
        .getAllCategories()
        .then((value) => categoryList = value.obs);
    super.onReady();
  }
}
