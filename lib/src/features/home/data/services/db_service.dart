import 'package:bottleshopdeliveryapp/src/core/data/res/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/database_service.dart';
import 'package:bottleshopdeliveryapp/src/features/home/data/models/slider_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/product_model.dart';

DatabaseService<SliderModel> homeSliderDb = DatabaseService<SliderModel>(
  AppDBConstants.appSettingsCollection,
  fromSnapshot: (id, data) => SliderModel.fromMap(data, id),
);

class FavoritesDBService extends DatabaseService<ProductModel> {
  String collection;

  FavoritesDBService(this.collection)
      : super(collection,
            fromSnapshot: (id, data) => ProductModel.fromJson(data));
}
