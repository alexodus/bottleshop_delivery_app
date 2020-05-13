import 'package:bottleshopdeliveryapp/src/utils/route_generator.dart';
import 'package:bottleshopdeliveryapp/src/utils/ui_helper.dart';
import 'package:bottleshopdeliveryapp/src/widgets/CreditCardsWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();

  CheckoutScreen({Key key}) : super(key: key);
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.backward,
              color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: <Widget>[
          ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(300),
              onTap: () {
                Navigator.pushNamed(context, RoutePaths.tabs, arguments: 1);
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
                leading: FaIcon(
                  FontAwesomeIcons.creditCard,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Payment Mode',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  'Select your prefered payment mode',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            SizedBox(height: 20),
            CreditCardsWidget(),
            SizedBox(height: 40),
            Text(
              'Or Checkout With',
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 320,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutePaths.checkoutCompleted);
                },
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Theme.of(context).focusColor.withOpacity(0.2),
                shape: StadiumBorder(),
                child: Image.asset(
                  'assets/images/paypal.png',
                  height: 28,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 320,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutePaths.checkoutCompleted);
                },
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Theme.of(context).focusColor.withOpacity(0.2),
                shape: StadiumBorder(),
                child: Image.asset(
                  'assets/images/apple_pay.png',
                  height: 28,
                ),
              ),
            ),
            SizedBox(height: 20),
            Stack(
              fit: StackFit.loose,
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                SizedBox(
                  width: 320,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RoutePaths.checkoutCompleted);
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
                    '\$55.36',
                    style: Theme.of(context).textTheme.display1.merge(
                        TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
