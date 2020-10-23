import 'package:bottleshopdeliveryapp/src/core/data/res/constants.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/database_service.dart';
import 'package:bottleshopdeliveryapp/src/features/orders/data/models/order_model.dart';

DatabaseService<OrderModel> ordersDbService = DatabaseService(
  AppDBConstants.ordersCollection,
  fromSnapshot: (id, data) => OrderModel.fromJson(data, id),
);
