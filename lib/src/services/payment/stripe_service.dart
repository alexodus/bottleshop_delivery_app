import 'package:bottleshopdeliveryapp/src/models/order.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {
  StripeService();

  void initState() {
    StripePayment.setOptions(
      StripeOptions(
        merchantId: 'merchantId',
        publishableKey: 'pk_test_Vd8ohpA150YuZ0fi8XgLlqPB00DEFPDxwa',
        androidPayMode: 'test',
      ),
    );
  }

  Future<bool> checkIfNativePayReady() async {
    var deviceSupportNativePay = await StripePayment.deviceSupportsNativePay();
    var isNativeReady = await StripePayment.canMakeNativePayPayments(
        ['visa', 'maestro', 'master_card']);
    return deviceSupportNativePay && isNativeReady;
  }

  Future<void> createPaymentMethodNative(Order toPay) async {
    StripePayment.setStripeAccount(null);
    var items = <ApplePayItem>[];
    items.add(ApplePayItem(
      label: 'Demo Order',
      amount: toPay.totalValue.toString(),
    ));
    if (toPay.tax != 0.0) {
      var tax = ((toPay.totalValue * toPay.tax) * 100).ceil() / 100;
      items.add(ApplePayItem(
        label: 'Tax',
        amount: tax.toString(),
      ));
    }
    items.add(ApplePayItem(
      label: 'Bottleshop 3 Veze',
      amount: (toPay.totalValue + toPay.tax).toString(),
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
        ? processPaymentAsDirectCharge(paymentMethod)
        : showDialog(
            context: context,
            builder: (BuildContext context) => ShowDialogToDismiss(
                title: 'Error',
                content:
                    'It is not possible to pay with this card. Please try again with a different card',
                buttonText: 'CLOSE'));
  }

  Future<void> createPaymentMethod(Order toPay) async {
    StripePayment.setStripeAccount(null);
    var tax = ((toPay.totalValue * 0.19) * 100).ceil() / 100;
    var amount = ((toPay.totalValue + tax) * 100).toInt();
    var paymentMethod = PaymentMethod();
    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) {
      return paymentMethod;
    }).catchError((e) {
      print('Errore Card: ${e.toString()}');
    });
    paymentMethod != null
        ? processPaymentAsDirectCharge(paymentMethod)
        : showDialog(
            context: context,
            builder: (BuildContext context) => ShowDialogToDismiss(
                title: 'Error',
                content:
                    'It is not possible to pay with this card. Please try again with a different card',
                buttonText: 'CLOSE'));
  }
}
