import 'package:bottleshopdeliveryapp/src/repositories/user_repository.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/account_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/checkout_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/app_scaffold.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/cart_item.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/profile_avatar_widget.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartView extends HookWidget {
  static const String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldKey: GlobalKey<ScaffoldState>(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: <Widget>[
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(300),
              onTap: () => Navigator.pushNamed(context, AccountView.routeName),
              child: useProvider(userDetailsProvider).when(
                data: (value) => ProfileAvatar(imageUrl: value.avatar),
                error: (_, __) => ProfileAvatar(imageUrl: null),
                loading: () => ProfileAvatar(imageUrl: null),
              ),
            ),
          ),
        ],
      ),
      body: CartBody(context: context),
    );
  }
}

class CartBody extends HookWidget {
  const CartBody({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 150),
          padding: EdgeInsets.only(bottom: 15),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      'Shopping Cart',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    subtitle: Text(
                      'Verify your quantity and click checkout',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
                useProvider(shoppingCartProvider).when(
                  data: (cart) => ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: cart.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 15);
                    },
                    itemBuilder: (context, index) {
                      return CartItem(
                        product: cart.elementAt(index).product,
                        heroTag: 'cart',
                        quantity: cart.elementAt(index).product.count,
                      );
                    },
                  ),
                  loading: null,
                  error: null,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 170,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.15),
                      offset: Offset(0, -2),
                      blurRadius: 5.0)
                ]),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Subtotal',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Text('\$50.23',
                          style: Theme.of(context).textTheme.subtitle2),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'TAX (20%)',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Text('\$13.23',
                          style: Theme.of(context).textTheme.subtitle2),
                    ],
                  ),
                  SizedBox(height: 10),
                  Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: FlatButton(
                          onPressed: () => Navigator.pushNamed(
                              context, CheckoutView.routeName),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          child: Text(
                            'Checkout',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '\$55.36',
                          style: Theme.of(context).textTheme.headline4.merge(
                              TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
