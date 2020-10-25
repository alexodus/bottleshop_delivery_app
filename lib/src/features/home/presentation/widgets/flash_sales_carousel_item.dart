import 'package:bottleshopdeliveryapp/src/core/data/models/route_argument.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/product_model.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/pages/product_detail_page.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/available_progress_bar.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FlashSalesCarouselItem extends HookWidget {
  final String heroTag;
  final double marginLeft;
  final ProductModel product;

  const FlashSalesCarouselItem({
    Key key,
    @required this.heroTag,
    @required this.marginLeft,
    @required this.product,
  })  : assert(heroTag != null),
        assert(marginLeft != null),
        assert(product != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailPage.routeName,
            arguments: RouteArgument(
                id: product.uniqueId, argumentsList: [product, heroTag]));
      },
      child: Container(
        margin: EdgeInsets.only(left: marginLeft, right: 20),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Hero(
              tag: heroTag + product.uniqueId,
              child: ProductImage(
                imagePath: product.imagePath,
                thumbnailPath: product.thumbnailPath,
                width: 160,
                height: 200,
              ),
            ),
            if (product.discount != null)
              Positioned(
                top: 6,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Theme.of(context).accentColor),
                  alignment: AlignmentDirectional.topEnd,
                  child: Text(
                    '- ${product.discount * 100} %',
                    style: Theme.of(context).textTheme.bodyText1.merge(
                        TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 170),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              width: 140,
              height: 113,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  Row(
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
                  SizedBox(height: 7),
                  Text(
                    '${product.count.toString()} Available',
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AvailableProgressBar(available: product.count.toDouble())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
