import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/checkout/presentation/viewmodels/checkout_view_model.dart';
import 'package:bottleshopdeliveryapp/src/features/orders/data/models/order_model.dart';
import 'package:hooks_riverpod/all.dart';

final demoOrder = OrderModel(
  id: '1',
  orderId: 1,
  customer: null,
  orderType: null,
  note: null,
  cartItems: null,
  totalPaid: null,
  statusStepId: null,
  statusStepsDates: null,
);

final nativePayProvider = FutureProvider<bool>((ref) async {
  final stripe = ref.watch(stripeProvider);
  final bool isNativePayAvailable = await stripe.checkIfNativePayReady();
  return isNativePayAvailable;
});

final checkoutStateProvider = ChangeNotifierProvider(
  (ref) => CheckoutState(
    orderToPay: demoOrder,
    read: ref.read,
  ),
);
