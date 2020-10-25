import 'package:bottleshopdeliveryapp/src/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';

class ShoppingCartButton extends StatelessWidget {
  final Color iconColor;
  final Color labelColor;
  final int labelCount;

  const ShoppingCartButton({
    Key key,
    @required this.iconColor,
    @required this.labelColor,
    this.labelCount = 0,
  })  : assert(iconColor != null),
        assert(labelColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.pushNamed(context, CartPage.routeName),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(
              Icons.shopping_cart,
              color: iconColor,
              size: 28,
            ),
          ),
          Container(
            child: Text(
              labelCount.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.merge(
                    TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 9,
                    ),
                  ),
            ),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: labelColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            constraints: BoxConstraints(
                minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
          ),
        ],
      ),
      color: Colors.transparent,
    );
  }
}
