import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/flash_sales_carousel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductHomeTab extends StatelessWidget {
  final Product product;
  final List<Product> flashSalesList;

  const ProductHomeTab({Key key, this.product, this.flashSalesList}) : super(key: key);

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
              Text(product.price.toStringAsFixed(2), style: Theme.of(context).textTheme.headline2),
              SizedBox(width: 10),
              Text(
                product.price.toStringAsFixed(2),
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .merge(TextStyle(color: Theme.of(context).focusColor, decoration: TextDecoration.lineThrough)),
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
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Select Color',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(0),
                    minWidth: 0,
                    child: Text(
                      'Clear All',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.15), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Select Size',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(0),
                    minWidth: 0,
                    child: Text(
                      'Clear All',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: FaIcon(
              FontAwesomeIcons.box,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Related Poducts',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        FlashSalesCarousel(heroTag: 'product_related_products', productsList: flashSalesList),
      ],
    );
  }
}
