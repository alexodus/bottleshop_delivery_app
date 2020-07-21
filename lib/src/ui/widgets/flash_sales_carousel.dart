import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:flutter/material.dart';

import 'flash_sales_carousel_item.dart';

class FlashSalesCarousel extends StatelessWidget {
  final List<Product> productsList;
  final String heroTag;

  const FlashSalesCarousel({
    Key key,
    this.productsList,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            double _marginLeft = 0;
            (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
            return FlashSalesCarouselItem(
              heroTag: this.heroTag,
              marginLeft: _marginLeft,
              product: productsList.elementAt(index),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
