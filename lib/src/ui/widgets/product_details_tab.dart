import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/flash_sales_carousel.dart';
import 'package:flutter/material.dart';

class ProductDetailsTab extends StatelessWidget {
  final Product product;
  final List<Product> flashSaleList;

  ProductDetailsTab({
    Key key,
    @required this.product,
    @required this.flashSaleList,
  })  : assert(product != null),
        assert(flashSaleList != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              Icons.create_new_folder,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Description',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
              'We’re all going somewhere. And whether it’s the podcast blaring from your headphones as you walk down the street or the essay that encourages you to take on that big project, there’s a real joy in getting lost in the kind of story that feels like a destination unto itself.'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              Icons.check_box,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Related Products',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        FlashSalesCarousel(
          heroTag: 'product_details_related_products',
        ),
      ],
    );
  }
}
