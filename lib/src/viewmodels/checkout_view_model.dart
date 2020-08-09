import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/services/payment/stripe_service.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class CheckoutViewModel extends BaseViewModel {
  final logger = Analytics.getLogger('CheckoutViewModel');
  CheckoutViewModel(Locator locator) : super(locator: locator);
  final _order = Order(
    products: [
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
      )
    ],
    orderPlacedOn: DateTime.now(),
    orderState: OrderState.toBeShipped,
    totalValue: 14.70,
    tax: 0.47,
  );

  Order get orderToCheckout => _order;
  double get totalValue {
    return _order.totalValue + _order.tax;
  }

  Future<bool> get isNativePaymentSupported async =>
      locator<StripeService>().checkIfNativePayReady();

  Future<void> payByApplePay() async {
    logger.v('payByApplePAy invoked');
    var canPayByApple = await locator<StripeService>().checkIfNativePayReady();
    if (canPayByApple) {
      logger.d('apple pay supported');
      await locator<StripeService>().createPaymentMethodNative(orderToCheckout);
    } else {
      logger.w('applePAy not supported');
    }
  }

  Future<void> payByGooglePay() async {
    logger.v('payByGooglePay invoked');
    var canPayByGoogle = await locator<StripeService>().checkIfNativePayReady();
    if (canPayByGoogle) {
      logger.d('google pay supported');
    } else {
      logger.w('google not supported');
    }
  }

  Future<void> payByCreditCard() async {
    logger.v('payByCreditCard invoked');
    await locator<StripeService>().createPaymentMethod(orderToCheckout);
  }
}
