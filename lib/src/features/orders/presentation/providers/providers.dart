import 'package:bottleshopdeliveryapp/src/core/data/services/database_service.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/orders/data/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/features/orders/data/services/db_service.dart';
import 'package:hooks_riverpod/all.dart';

final ordersProvider = StreamProvider.autoDispose<List<OrderModel>>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  final query = QueryArgs(OrderModel.userField, isEqualTo: currentUser.uid);
  final orderBy = OrderBy(OrderModel.createdAtTimestampField, descending: true);
  final orders =
      ordersDbService.streamQueryList(orderBy: [orderBy], args: [query]);
  return orders;
});
