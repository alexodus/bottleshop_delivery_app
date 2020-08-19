import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/flash_sales_carousel_item.dart';
import 'package:flutter/material.dart';

class FlashSalesCarousel extends StatelessWidget {
  final String heroTag;
  final List<Product> productList;

  const FlashSalesCarousel({
    Key key,
    @required this.heroTag,
    @required this.productList,
  })  : assert(productList != null),
        assert(heroTag != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            var _marginLeft = 0.0;
            (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
            return FlashSalesCarouselItem(
              heroTag: heroTag,
              marginLeft: _marginLeft,
              product: productList.elementAt(index),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
