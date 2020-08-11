import 'dart:io';

import 'package:bottleshopdeliveryapp/src/ui/views/account_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/checkout_done.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/app_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/credit_cards.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/dissmisable_dialog.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/profile_avatar_widget.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/shopping_cart_button.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/checkout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatelessWidget {
  static const String routeName = '/checkout';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CheckoutView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckoutViewModel>(
        create: (_) => CheckoutViewModel(context.read),
        builder: (context, child) {
          return AppScaffold(
            scaffoldKey: _scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon:
                    Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Checkout',
                style: Theme.of(context).textTheme.headline4,
              ),
              actions: <Widget>[
                ShoppingCartButton(
                    iconColor: Theme.of(context).hintColor,
                    labelColor: Theme.of(context).accentColor),
                Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(300),
                    onTap: () {
                      Navigator.pushNamed(context, AccountView.routeName);
                    },
                    child: ProfileAvatar(),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        Icons.credit_card,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Payment Mode',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      subtitle: Text(
                        'Select your preferred payment mode',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CreditCards(),
                  SizedBox(height: 40),
                  PayButton(),
                  SizedBox(height: 20),
                  NativePayments(),
                ],
              ),
            ),
          );
        });
  }
}

class NativePayments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: context.watch<CheckoutViewModel>().isNativePaymentSupported,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          debugPrint('data ${snapshot.data}');
          return Offstage(
            offstage: !snapshot.data,
            child: Column(
              children: [
                Text(
                  'Or Checkout With',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 320,
                  child: FlatButton(
                    onPressed: () async {
                      try {
                        await context
                            .read<CheckoutViewModel>()
                            .payByNativePay();
                        return Navigator.pushReplacementNamed(
                            context, CheckoutDoneView.routeName);
                      } catch (e) {
                        await showDialog(
                          context: context,
                          builder: (builder) => DissmisableDialog(
                            title: Platform.isIOS
                                ? 'Apple Pay Error'
                                : 'Google Pay Error',
                            content:
                                'It is not possible to pay with this card. Please try again with a different card',
                            buttonText: Platform.isIOS ? 'CLOSE' : 'Cancel',
                          ),
                        );
                      }
                    },
                    padding: EdgeInsets.symmetric(vertical: 12),
                    color: Theme.of(context).primaryColorLight,
                    shape: StadiumBorder(),
                    child: Image.asset(
                      Platform.isIOS
                          ? 'assets/images/apple_pay.png'
                          : 'assets/images/google_pay.png',
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class PayButton extends StatelessWidget {
  const PayButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalValue =
        context.select((CheckoutViewModel viewModel) => viewModel.totalAmount);
    return Stack(
      fit: StackFit.loose,
      alignment: AlignmentDirectional.centerEnd,
      children: <Widget>[
        SizedBox(
          width: 320,
          child: FlatButton(
            onPressed: () async {
              try {
                await context.read<CheckoutViewModel>().payByCreditCard();
                return Navigator.pushReplacementNamed(
                    context, CheckoutDoneView.routeName);
              } catch (e) {
                await showDialog(
                  context: context,
                  builder: (context) => DissmisableDialog(
                    title:
                        Platform.isIOS ? 'Apple Pay Error' : 'Google Pay Error',
                    content:
                        'It is not possible to pay with this card. Please try again with a different card',
                    buttonText: Platform.isIOS ? 'CLOSE' : 'Cancel',
                  ),
                );
              }
            },
            padding: EdgeInsets.symmetric(vertical: 14),
            color: Theme.of(context).accentColor,
            shape: StadiumBorder(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Confirm Payment',
                textAlign: TextAlign.start,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            totalValue,
            style: Theme.of(context)
                .textTheme
                .headline4
                .merge(TextStyle(color: Theme.of(context).primaryColor)),
          ),
        )
      ],
    );
  }
}
