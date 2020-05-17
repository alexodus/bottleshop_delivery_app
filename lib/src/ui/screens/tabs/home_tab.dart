import 'package:bottleshopdeliveryapp/src/core/models/category.dart';
import 'package:bottleshopdeliveryapp/src/core/models/product.dart';
import 'package:bottleshopdeliveryapp/src/core/services/database/mock_database_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/CategoriesIconsCarouselWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/CategorizedProductsWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/FlashSalesCarouselWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/FlashSalesWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/HomeSliderWidget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomeTabState createState() => _HomeTabState();

  HomeTab({Key key}) : super(key: key);
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  List<Product> _productsOfCategoryList;
  List<Category> _categoriesList;
  List<Product> _flashSales;

  Animation animationOpacity;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    animationController.forward();
    _categoriesList = MockDatabaseService().categories;
    _flashSales = MockDatabaseService().flashSalesList;

    _productsOfCategoryList = _categoriesList.firstWhere((category) {
      return category.selected;
    }).products;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchBarWidget(),
        ),
        HomeSliderWidget(),
        FlashSalesHeaderWidget(),
        FlashSalesCarouselWidget(
            heroTag: 'home_flash_sales', productsList: _flashSales),
        // Heading (Recommended for you)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: FaIcon(
              FontAwesomeIcons.star,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Recommended For You',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        StickyHeader(
          header: CategoriesIconsCarouselWidget(
              heroTag: 'home_categories_1',
              categoriesList: _categoriesList,
              onChanged: (id) {
                setState(() {
                  animationController.reverse().then((f) {
                    _productsOfCategoryList =
                        _categoriesList.firstWhere((category) {
                      return category.id == id;
                    }).products;
                    animationController.forward();
                  });
                });
              }),
          content: CategorizedProductsWidget(
              animationOpacity: animationOpacity,
              productsList: _productsOfCategoryList),
        ),
      ],
    );
//      ],
//    );
  }
}
