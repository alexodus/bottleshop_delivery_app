import 'package:bottleshopdeliveryapp/src/core/data/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/features/orders/data/models/order_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/pages/product_detail_page.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';

class OrderListItem extends StatelessWidget {
  final String heroTag;
  final OrderModel order;
  final VoidCallback onDismissed;

  const OrderListItem({
    Key key,
    @required this.heroTag,
    @required this.order,
    @required this.onDismissed,
  })  : assert(heroTag != null),
        assert(order != null),
        assert(onDismissed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteArgument args = ModalRoute.of(context).settings.arguments;
    return Dismissible(
      key: Key(order.hashCode.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        onDismissed();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'The ${order.cartItems[0].product.name} order is removed from wish list'),
          ),
        );
      },
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.pushNamed(context, ProductDetailPage.routeName,
              arguments: args);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                tag: heroTag + order.id,
                child: ProductImage(
                    imagePath: order.cartItems[0].product.imagePath),
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
                            order.cartItems[0].product.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.calendar_today,
                                    color: Theme.of(context).focusColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    order.statusStepsDates[0].toIso8601String(),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.show_chart,
                                    color: Theme.of(context).focusColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '5',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ],
//                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                            order.cartItems[0].product.priceNoVat
                                .toStringAsFixed(2),
                            style: Theme.of(context).textTheme.headline4),
                        SizedBox(height: 6),
                        Chip(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          backgroundColor: Colors.transparent,
                          shape: StadiumBorder(
                              side: BorderSide(
                                  color: Theme.of(context).focusColor)),
                          label: Text(
                            'x ${5}',
                            style:
                                TextStyle(color: Theme.of(context).focusColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
