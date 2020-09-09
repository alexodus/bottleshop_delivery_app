import 'dart:convert';

import 'package:bottleshopdeliveryapp/src/constants/constants.dart';
import 'package:bottleshopdeliveryapp/src/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  final logger = Analytics.getLogger('StripeService');
  StripeService() {
    StripePayment.setOptions(
      StripeOptions(
        merchantId: Constants.applePayMerchantId,
        publishableKey: Constants.stripePublishableKey,
        androidPayMode: Constants.stripeAndroidPayMode,
      ),
    );
  }

  Future<bool> checkIfNativePayReady() async {
    var deviceSupportNativePay = await StripePayment.deviceSupportsNativePay();
    var isNativeReady = await StripePayment.canMakeNativePayPayments(
        Constants.stripeSupportedCards);
    return deviceSupportNativePay && isNativeReady;
  }

  Future<void> createPaymentMethodNative(OrderModel toPay) async {
    StripePayment.setStripeAccount(null);
    var applePayItems = <ApplePayItem>[];
    var googlePayItems = <LineItem>[];
    toPay.cartItems.forEach((item) {
      googlePayItems.add(LineItem(
        currencyCode: 'EUR',
        description: item.product.name,
        quantity: '1',
        totalPrice: item.product.priceNoVat.toStringAsFixed(2),
        unitPrice: item.product.priceNoVat.toStringAsFixed(2),
      ));
    });
    applePayItems.add(ApplePayItem(
        label: 'Order #1p3o4', amount: toPay.totalPaid.toStringAsFixed(2)));
    applePayItems.add(ApplePayItem(
        label: 'Tax 20 %',
        amount: (toPay.totalPaid * 1.19).toStringAsFixed(2)));
    applePayItems.add(ApplePayItem(
      label: 'Bottleshop 3 Veze',
      amount: (toPay.totalPaid).toStringAsFixed(2),
    ));
    var paymentMethod = PaymentMethod();
    var token = await StripePayment.paymentRequestWithNativePay(
      androidPayOptions: AndroidPayPaymentRequest(
        totalPrice: (toPay.totalPaid).toStringAsFixed(2),
        currencyCode: 'EUR',
        lineItems: googlePayItems,
      ),
      applePayOptions: ApplePayPaymentOptions(
        countryCode: 'SK',
        currencyCode: 'EUR',
        items: applePayItems,
      ),
    );
    paymentMethod = await StripePayment.createPaymentMethod(
      PaymentMethodRequest(
        card: CreditCard(
          token: token.tokenId,
        ),
      ),
    );
    if (paymentMethod != null) {
      return processPaymentAsDirectCharge(
          paymentMethod, (toPay.totalPaid * 100).toString(), toPay.id);
    } else {
      throw ErrorCode(
          errorCode: 'createMethod',
          description:
              'It is not possible to pay with this card. Please try again with a different card');
    }
  }

  Future<void> createPaymentMethod(OrderModel toPay) async {
    StripePayment.setStripeAccount(null);
    var paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest());
    if (paymentMethod != null) {
      return processPaymentAsDirectCharge(
          paymentMethod, (toPay.totalPaid * 100).toString(), toPay.id);
    } else {
      throw ErrorCode(
          errorCode: 'createMethod',
          description:
              'It is not possible to pay with this card. Please try again with a different card');
    }
  }

  Future<void> processPaymentAsDirectCharge(
      PaymentMethod paymentMethod, String amount, String description) async {
    const url = Constants.stripeCloudFunctionUrl;
    logger.d('ID: ${paymentMethod.id}');
    final response = await http.post(
        '$url?amount=$amount&paym=${paymentMethod.id}&description=$description');
    logger.d('payment response: ${response.body}');
    if (response.statusCode == 200 &&
        response.body != null &&
        response.body != 'error') {
      final paymentIntentX = jsonDecode(response.body);
      final status = paymentIntentX['paymentIntent']['status'];
      final strAccount = paymentIntentX['stripeAccount'];
      if (status == 'succeeded') {
        await StripePayment.completeNativePayRequest();
      } else {
        StripePayment.setStripeAccount(strAccount);
        try {
          var intentResult = await StripePayment.confirmPaymentIntent(
              PaymentIntent(
                  paymentMethodId: paymentIntentX['paymentIntent']
                      ['payment_method'],
                  clientSecret: paymentIntentX['paymentIntent']
                      ['client_secret']));
          final statusFinal = intentResult.status;
          if (statusFinal == 'succeeded') {
            await StripePayment.completeNativePayRequest();
          } else if (statusFinal == 'processing') {
            await StripePayment.cancelNativePayRequest();
            throw ErrorCode(
                errorCode: 'processing',
                description:
                    'The payment is still in \'processing\' state. This is unusual. Please contact us');
          } else {
            await StripePayment.cancelNativePayRequest();
            throw ErrorCode(
                errorCode: statusFinal,
                description:
                    'There was an error to confirm the payment. Details: $statusFinal');
          }
        } on ErrorCode {
          rethrow;
        } catch (e) {
          throw ErrorCode(
              errorCode: 'authentication',
              description: 'There was an error to confirm the payment. '
                  'Please try again with another card');
        }
      }
    } else {
      await StripePayment.cancelNativePayRequest();
      throw ErrorCode(
          errorCode: 'payment',
          description:
              'There was an error in creating the payment. Please try again with another card');
    }
  }
}
