import 'dart:convert';

import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  final logger = Analytics.getLogger('StripeService');
  StripeService() {
    StripePayment.setOptions(
      StripeOptions(
        merchantId: 'merchant.sk.bottleshop3veze.bottleshopdeliveryapp',
        publishableKey: 'pk_test_Gnq83EyihTQEkX5vR7Mlf3Ec00jzaAL91B',
        androidPayMode: 'test',
      ),
    );
  }

  Future<bool> checkIfNativePayReady() async {
    var deviceSupportNativePay = await StripePayment.deviceSupportsNativePay();
    var isNativeReady = await StripePayment.canMakeNativePayPayments(
      [
        'american_express',
        'visa',
        'maestro',
        'master_card',
      ],
    );
    return deviceSupportNativePay && isNativeReady;
  }

  Future<void> createPaymentMethodNative(Order toPay) async {
    StripePayment.setStripeAccount(null);
    var items = <ApplePayItem>[];
    items.add(ApplePayItem(
      label: 'Bottleshop 3 Veze ${toPay.documentId}',
      amount: toPay.totalValue.toStringAsFixed(2),
    ));
    var paymentMethod = PaymentMethod();
    var token = await StripePayment.paymentRequestWithNativePay(
      androidPayOptions: AndroidPayPaymentRequest(
        totalPrice: (toPay.totalValue + toPay.tax).toStringAsFixed(2),
        currencyCode: 'EUR',
      ),
      applePayOptions: ApplePayPaymentOptions(
        countryCode: 'SK',
        currencyCode: 'EUR',
        items: items,
      ),
    );
    paymentMethod = await StripePayment.createPaymentMethod(
      PaymentMethodRequest(
        card: CreditCard(
          token: token.tokenId,
        ),
      ),
    );
    paymentMethod != null
        ? await processPaymentAsDirectCharge(paymentMethod, toPay.totalValue)
        : throw 'payment method not supported';
  }

  Future<void> createPaymentMethod(Order toPay) async {
    StripePayment.setStripeAccount(null);
    var paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest());
    paymentMethod != null
        ? await processPaymentAsDirectCharge(paymentMethod, toPay.totalValue)
        : throw 'createPaymentMethod '
            'failed';
  }

  Future<void> processPaymentAsDirectCharge(
      PaymentMethod paymentMethod, double amount) async {
    const url =
        'https://us-central1-bottleshop3veze-delivery.cloudfunctions.net/StripePI';
    logger.d('ID: ${paymentMethod.id}');
    final response =
        await http.post('$url?amount=1000&paym=${paymentMethod.id}');
    logger.d('payment response: ${response.body}');
    if (response.body != null && response.body != 'error') {
      final paymentIntentX = jsonDecode(response.body);
      final status = paymentIntentX['paymentIntent']['status'];
      final strAccount = paymentIntentX['stripeAccount'];
      if (status == 'succeeded') {
        await StripePayment.completeNativePayRequest();
      } else {
        StripePayment.setStripeAccount(strAccount);
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
          throw 'payment failed';
        } else {
          await StripePayment.cancelNativePayRequest();
          throw 'payment not confirmed';
        }
      }
    } else {
      //case A
      await StripePayment.cancelNativePayRequest();
      throw 'payment failed';
    }
  }
}
