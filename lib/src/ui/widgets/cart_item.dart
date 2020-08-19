import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/services/analytics/analytics.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/product_detail_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/product_image.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String heroTag;
  final Product product;
  final int quantity;

  const CartItem({
    Key key,
    @required this.product,
    @required this.heroTag,
    this.quantity = 1,
  })  : assert(heroTag != null),
        assert(product != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final logger = Analytics.getLogger('CartItem');
    final RouteArgument args = ModalRoute.of(context).settings.arguments;
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.pushNamed(context, ProductDetailView.routeName,
            arguments:
                RouteArgument(id: args.id, argumentsList: args.argumentsList));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: heroTag + product.documentID,
              child: ProductImage(
                height: 90,
                width: 90,
                imageUrl: product.imageUrl,
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          product.price.toStringAsFixed(2),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          //logger.d('quantity: $incrementQuantity(quantity)');
                        },
                        iconSize: 30,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        icon: Icon(Icons.add_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                      Text(quantity.toString(),
                          style: Theme.of(context).textTheme.subtitle1),
                      IconButton(
                        onPressed: () {
                          //logger.d('quantity: $decrementQuantity(quantity)');
                        },
                        iconSize: 30,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        icon: Icon(Icons.remove_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
