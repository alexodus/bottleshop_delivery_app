import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/payment/stripe_service.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CheckoutViewModel extends BaseViewModel {
  final logger = Analytics.getLogger('CheckoutViewModel');
  CheckoutViewModel(Locator locator) : super(locator: locator);
  final _order = Order.fromProducts(
    [
      Product(
        documentID: 'd01521a0-d505-11ea-9944-bb2a231d2373',
        alcohol: '40',
        amount: 20,
        category: 'Cognac',
        country: 'France',
        name: 'Mery Melrose VS Organic ',
        newEntry: false,
        price: 14.70,
        recommended: false,
        unit: 'liter',
        unitValue: 0.70,
        imageUrl:
            'gs://bottleshop3veze-delivery.appspot.com/warehouse/999010081.jpeg',
      ),
      Product(
        documentID: 'd01521a0-d505-11ea-9944-bb2a231d2372',
        alcohol: '40',
        amount: 20,
        category: 'Cognac',
        country: 'France',
        name: 'Mery Melrose VS Organic ',
        newEntry: false,
        price: 10.70,
        recommended: false,
        unit: 'liter',
        unitValue: 0.70,
        discount: 0.1,
        imageUrl:
            'gs://bottleshop3veze-delivery.appspot.com/warehouse/999010081.jpeg',
      )
    ],
  );

  Order get orderToCheckout => _order;
  String get totalAmount => (_order.totalValue + _order.tax).toStringAsFixed(2);

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
