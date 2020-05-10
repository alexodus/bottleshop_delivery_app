import 'package:bottleshopdeliveryapp/src/models/brand.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/services/mock_database_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'FlashSalesCarouselWidget.dart';
import 'HomeSliderWidget.dart';

class BrandHomeTabWidget extends StatefulWidget {
  final Brand brand;
  final List<Product> flashSales = MockDatabaseService().flashSalesList;

  BrandHomeTabWidget({this.brand});

  @override
  _BrandHomeTabWidgetState createState() => _BrandHomeTabWidgetState();
}

class _BrandHomeTabWidgetState extends State<BrandHomeTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: FaIcon(
              FontAwesomeIcons.flag,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              widget.brand.name,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        HomeSliderWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: FaIcon(
              FontAwesomeIcons.star,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Description',
              style: Theme.of(context).textTheme.display1,
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
            leading: FaIcon(
              FontAwesomeIcons.trophy,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Featured Products',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        FlashSalesCarouselWidget(
          heroTag: 'brand_featured_products',
          productsList: widget.flashSales,
        ),
      ],
    );
  }
}
