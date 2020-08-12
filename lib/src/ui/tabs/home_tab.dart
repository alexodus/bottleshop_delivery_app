import 'package:bottleshopdeliveryapp/src/ui/widgets/categories_icons_carousel.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/categorized_products.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/flash_sales_carousel.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/flash_sales_header.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/home_slider.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/search_bar.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/home_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _HomeTabState createState() => _HomeTabState();

  HomeTab({Key key}) : super(key: key);
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  Animation animationOpacity;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    var curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeTabViewModel>(
      create: (_) => HomeTabViewModel(context.read),
      builder: (context, child) {
        return ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBar(
                showFilter: true,
              ),
            ),
            HomeSlider(),
            FlashSalesHeader(),
            FlashSalesCarousel(
              heroTag: 'home_flash_sales',
            ),
            // Heading (Recommended for you)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.star,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Recommended For You',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            StickyHeader(
              header: CategoriesIconsCarousel(tickerProvider: this),
              content: CategorizedProducts(animationOpacity: animationOpacity),
            ),
          ],
        );
      },
    );
  }
}
