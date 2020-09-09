import 'package:bottleshopdeliveryapp/src/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductHomeTab extends StatelessWidget {
  final ProductModel product;

  const ProductHomeTab({
    Key key,
    @required this.product,
  })  : assert(product != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Chip(
                padding: EdgeInsets.all(0),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '5.0',
                      style: Theme.of(context).textTheme.bodyText2.merge(
                            TextStyle(color: Theme.of(context).primaryColor),
                          ),
                    ),
                    Icon(
                      Icons.star_border,
                      color: Theme.of(context).primaryColor,
                      size: 16,
                    ),
                  ],
                ),
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                shape: StadiumBorder(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(product.priceNoVat.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.headline2),
              SizedBox(width: 10),
              Text(
                product.priceNoVat.toStringAsFixed(2),
                style: Theme.of(context).textTheme.headline5.merge(TextStyle(
                    color: Theme.of(context).focusColor,
                    decoration: TextDecoration.lineThrough)),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '5.0 Sales',
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
