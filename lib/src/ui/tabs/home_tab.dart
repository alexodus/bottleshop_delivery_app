import 'package:bottleshopdeliveryapp/src/repositories/product_repository.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/categories_icons_carousel.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/categorized_products.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/flash_sales_carousel.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/flash_sales_header.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/home_slider.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeTab extends HookWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final tickerProvider = useSingleTickerProvider();
    final animationController = useAnimationController(
        duration: Duration(milliseconds: 200), vsync: tickerProvider);
    final curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    final Animation animationOpacity =
        Tween(begin: 0.0, end: 1.0).animate(curve);
    final animation = useAnimation(animationOpacity);
    animationController.forward();
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
          dataStream:
              context.read(productRepositoryProvider).getProductsOnFlashSale(),
        ),
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
              'New arrivals',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        FlashSalesCarousel(
          heroTag: 'home_new_arrival',
          dataStream: context.read(productRepositoryProvider).getNewProducts(),
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
        FlashSalesCarousel(
          heroTag: 'home_recommended',
          dataStream:
              context.read(productRepositoryProvider).getRecommendedProducts(),
        ),
        StickyHeader(
          header: CategoriesIconsCarousel(),
          content: CategorizedProducts(animationOpacity: animation),
        ),
      ],
    );
  }
}
