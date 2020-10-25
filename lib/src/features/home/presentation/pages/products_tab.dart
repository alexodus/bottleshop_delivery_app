import 'package:bottleshopdeliveryapp/src/core/presentation/providers/core_providers.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/search_bar.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/carousel_animation_mixin.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/flash_sales_carousel.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/flash_sales_header.dart';
import 'package:bottleshopdeliveryapp/src/features/home/presentation/widgets/home_slider.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class ProductsTab extends HookWidget with CarouselAnimationMixin {
  static const String tabKey = 'productsTab';

  @override
  Widget build(BuildContext context) {
    final _logger = useProvider(loggerProvider('ProductsTab'));
    runHooks();
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
        buildAnimatedContainer(context),
      ],
    );
  }

  void runHooks() {
    handleAssignment();
    useEffect(_lifecycleEvents, []);
  }

  Dispose _lifecycleEvents() {
    componentDidMount();
    return componentWillUnmount;
  }

  void componentDidMount() {
    animationMixinFields.animationController.forward();
  }

  void componentWillUnmount() {}

  void handleAssignment() {
    final animationController =
        useAnimationController(duration: Duration(milliseconds: 350));
    animationMixinFields =
        useMemoized(() => CarouselAnimationMixinFields(animationController));
  }
}
