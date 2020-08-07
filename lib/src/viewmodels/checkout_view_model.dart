import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class CheckoutViewModel extends BaseViewModel {
  final logger = Analytics.getLogger('CheckoutViewModel');
  CheckoutViewModel(Locator locator) : super(locator: locator);

  Order get orderToCheckout => null;

  double get totalValue => 345.6;

  Future<void> payByApplePay() async {
    logger.v('payByApplePAy invoked');
    // TODO
  }

  Future<void> payByGooglePay() async {
    logger.v('payByGooglePay invoked');
    // TODO
  }

  Future<void> payByCreditCard() async {
    logger.v('payByCreditCard invoked');
    // TODO
  }

  Future<void> addCreditCard(String cardId) async {
    logger.v('addCreditCard invoked');
    // TODO
  }
}
