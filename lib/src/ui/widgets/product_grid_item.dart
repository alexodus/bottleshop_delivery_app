import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/product_detail_view.dart';
import 'package:flutter/material.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;
  final String heroTag;

  const ProductGridItem({
    Key key,
    @required this.product,
    @required this.heroTag,
  })  : assert(product != null),
        assert(heroTag != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.pushNamed(context, ProductDetailView.routeName,
            arguments: RouteArgument(argumentsList: [this.product, this.heroTag], id: this.product.documentID));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: this.heroTag + product.documentID,
              child: Image.asset(product.imageUrl),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                product.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                product.price.toStringAsFixed(2),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  // The title of the product
                  Expanded(
                    child: Text(
                      '5 Sales',
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 18,
                  ),
                  Text(
                    '5.0',
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
