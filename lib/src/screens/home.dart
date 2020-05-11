import 'package:bottleshopdeliveryapp/src/models/category.dart';
import 'package:bottleshopdeliveryapp/src/models/product.dart';
import 'package:bottleshopdeliveryapp/src/services/mock_database_service.dart';
import 'package:bottleshopdeliveryapp/src/widgets/CategoriesIconsCarouselWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/CategorizedProductsWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/FlashSalesWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/HomeSliderWidget.dart';
import 'package:bottleshopdeliveryapp/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  HomeScreen({Key key}) : super(key: key);
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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
