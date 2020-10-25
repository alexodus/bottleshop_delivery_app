import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/flash_sales_carousel_item.dart';
import 'package:bottleshopdeliveryapp/src/features/products/data/models/product_model.dart';
import 'package:flutter/material.dart';

class FlashSalesCarousel extends StatelessWidget {
  final String heroTag;
  final List<ProductModel> data;

  const FlashSalesCarousel({
    Key key,
    @required this.heroTag,
    @required this.data,
  })  : assert(heroTag != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          var _marginLeft = 0.0;
          (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
          final product = data.elementAt(index);
          return FlashSalesCarouselItem(
            heroTag: heroTag,
            marginLeft: _marginLeft,
            product: product,
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
