import 'package:bottleshopdeliveryapp/src/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/payment/stripe_service.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CheckoutViewModel extends BaseViewModel {
  final logger = Analytics.getLogger('CheckoutViewModel');

  CheckoutViewModel(Locator locator) : super(locator: locator);
  final _order = OrderModel(
      id: '1',
      orderId: 1,
      customer: null,
      orderType: null,
      note: null,
      cartItems: null,
      totalPaid: null,
      statusStepId: null,
      statusStepsDates: null);

  OrderModel get orderToCheckout => _order;

  String get totalAmount => (_order.totalPaid).toStringAsFixed(2);

  Future<bool> get isNativePaymentSupported async =>
      locator<StripeService>().checkIfNativePayReady();

  Future<void> payByNativePay() async {
    logger.v('payByNativePAy invoked');
    try {
      var canPayNatively =
          await locator<StripeService>().checkIfNativePayReady();
      if (canPayNatively) {
        logger.d('native pay supported');
        await locator<StripeService>()
            .createPaymentMethodNative(orderToCheckout);
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
      await locator<StripeService>().createPaymentMethod(orderToCheckout);
    } on ErrorCode {
      rethrow;
    } catch (e) {
      logger.e('payment failed: $e');
    }
  }
}
