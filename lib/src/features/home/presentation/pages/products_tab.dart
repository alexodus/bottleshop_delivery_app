import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/search_bar.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/flash_sales_carousel.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/flash_sales_header.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/home_slider.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/categories_icons_carousel.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/categorized_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ProductsTab extends HookWidget {
  static const String routeName = '/products';

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: Duration(milliseconds: 200));
    final curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    final animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve);
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
        useProvider(flashSalesProvider).when(
          data: (data) => FlashSalesCarousel(
            heroTag: 'home_flash_sales',
            data: data,
          ),
          loading: () => Container(),
          error: (_, __) => Container(),
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
        useProvider(newProductsProvider).when(
          data: (data) => FlashSalesCarousel(
            heroTag: 'home_new_arrival',
            data: data,
          ),
          loading: () => Container(),
          error: (_, __) => Container(),
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
              'Recommended For You',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        useProvider(recommendedProductsProvider).when(
          data: (data) => FlashSalesCarousel(
            heroTag: 'recommended_for_you',
            data: data,
          ),
          loading: () => Container(),
          error: (_, __) => Container(),
        ),
        StickyHeader(
          header: CategoriesIconsCarousel(),
          content: CategorizedProducts(animationOpacity: animationOpacity),
        ),
      ],
    );
  }
}
