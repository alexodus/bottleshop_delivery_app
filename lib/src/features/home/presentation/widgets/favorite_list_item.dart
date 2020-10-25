import 'package:bottleshopdeliveryapp/src/core/data/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/pages/product_detail_page.dart';
import 'package:flutter/material.dart';

class FavoriteListItem extends StatelessWidget {
  final String heroTag;
  final ProductModel product;
  final VoidCallback onDismissed;

  const FavoriteListItem({
    Key key,
    @required this.heroTag,
    @required this.product,
    this.onDismissed,
  })  : assert(heroTag != null),
        assert(product != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouteArgument args = ModalRoute.of(context).settings.arguments;
    return Dismissible(
      key: Key(product.hashCode.toString()),
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
            content:
                Text('The ${product.name} product is removed from wish list'),
          ),
        );
      },
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailPage.routeName,
            arguments: RouteArgument(
              argumentsList: [this.product, this.heroTag],
              id: this.product.uniqueId,
            ),
          );
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
                tag: heroTag + product.uniqueId,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: AssetImage(
                          product?.imageUrl ?? 'assets/images/generic.png',
                        ),
                        fit: BoxFit.cover),
                  ),
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
                          Row(
                            children: <Widget>[
                              // The title of the product
                              Text(
                                '5 Sales',
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              Text(
                                '5',
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(product.priceNoVat.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headline4),
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
