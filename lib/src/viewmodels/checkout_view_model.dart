import 'package:bottleshopdeliveryapp/src/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/payment/stripe_service.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:stripe_payment/stripe_payment.dart';

final demoOrder = OrderModel(
    id: '1',
    orderId: 1,
    customer: null,
    orderType: null,
    note: null,
    cartItems: null,
    totalPaid: null,
    statusStepId: null,
    statusStepsDates: null);

final nativePayProvider = FutureProvider<bool>((ref) async {
  final bool isNativePayAvailable =
      await StripeService().checkIfNativePayReady();
  return isNativePayAvailable;
});

final checkoutStateProvider =
    StateNotifierProvider((ref) => CheckoutState(null));

class CheckoutState extends StateNotifier<OrderModel> {
  final logger = Analytics.getLogger('CheckoutViewModel');
  CheckoutState(OrderModel order) : super(order ?? demoOrder);

  String get totalAmount => (state.totalPaid).toStringAsFixed(2);

  Future<void> payByNativePay() async {
    logger.v('payByNativePAy invoked');
    try {
      var canPayNatively = await StripeService().checkIfNativePayReady();
      if (canPayNatively) {
        logger.d('native pay supported');
        await StripeService().orderToCheckout;
      } else {
        logger.w('native pay not supported');
      }
    } on ErrorCode {
      rethrow;
    } catch (e) {
      logger.e('payment failed: $e');
    }
  }

  Future<void> payByCreditCard() async {
    logger.v('payByCreditCard invoked');
    try {
      await StripeService().createPaymentMethod(state);
    } on ErrorCode {
      rethrow;
    } catch (e) {
      logger.e('payment failed: $e');
    }
  }
}
