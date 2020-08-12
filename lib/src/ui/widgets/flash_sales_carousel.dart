import 'package:bottleshopdeliveryapp/src/ui/widgets/flash_sales_carousel_item.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/home_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashSalesCarousel extends StatelessWidget {
  final heroTag;

  const FlashSalesCarousel({
    Key key,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productList =
        context.select((HomeTabViewModel viewModel) => viewModel.flashSales);
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
