import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/orders/data/models/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:logger/logger.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CheckoutState extends ChangeNotifier {
  Logger _logger;
  Reader read;
  final OrderModel orderToPay;
  bool _isLoading = false;

  CheckoutState({this.orderToPay, this.read}) {
    _logger = createLogger(this.runtimeType.toString());
  }

  String get totalAmount => (orderToPay.totalPaid).toStringAsFixed(2);
  bool get isLoading => _isLoading;

  Future<void> payByNativePay() async {
    _logger.v('payByNativePAy invoked');
    _isLoading = true;
    notifyListeners();
    try {
      final stripe = read(stripeProvider);
      var canPayNatively = await stripe.checkIfNativePayReady();
      if (canPayNatively) {
        _logger.d('native pay supported');
        await stripe.orderToCheckout;
      } else {
        _logger.w('native pay not supported');
      }
    } on ErrorCode {
      rethrow;
    } catch (e) {
      _logger.e('payment failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> payByCreditCard() async {
    _isLoading = true;
    notifyListeners();
    _logger.v('payByCreditCard invoked');
    try {
      final stripe = read(stripeProvider);
      await stripe.createPaymentMethod(orderToPay);
    } on ErrorCode {
      rethrow;
    } catch (e) {
      _logger.e('payment failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
