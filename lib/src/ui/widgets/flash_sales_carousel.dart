import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:flutter/material.dart';

import 'flash_sales_carousel_item.dart';

class FlashSalesCarousel extends StatelessWidget {
  final List<Product> productsList;
  final String heroTag;

  const FlashSalesCarousel({
    Key key,
    @required this.productsList,
    @required this.heroTag,
  })  : assert(productsList != null),
        assert(heroTag != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            var _marginLeft = 0.0;
            (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
            return FlashSalesCarouselItem(
              heroTag: heroTag,
              marginLeft: _marginLeft,
              product: productsList.elementAt(index),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
