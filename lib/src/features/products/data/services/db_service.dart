import 'package:bottleshopdeliveryapp/src/core/data/res/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/database_service.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/category_plain_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/product_model.dart';

DatabaseService<ProductModel> productsDb = DatabaseService<ProductModel>(
  AppDBConstants.productsCollection,
  fromMap: (id, data) => ProductModel.fromJson(data),
  toMap: (product) => product.toFirebaseJson(),
);

DatabaseService<CategoryPlainModel> categoryDb =
    DatabaseService<CategoryPlainModel>(
  AppDBConstants.categoriesCollection,
  fromMap: (id, data) => CategoryPlainModel.fromJson(data, id),
);
