import 'package:bottleshopdeliveryapp/src/features/products/presentation/providers/providers.dart';
import 'package:bottleshopdeliveryapp/src/features/products/presentation/widgets/product_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/all.dart';

class CategorizedProducts extends HookWidget {
  final Animation<double> animationOpacity;

  const CategorizedProducts({
    Key key,
    @required this.animationOpacity,
  })  : assert(animationOpacity != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final categorizedProducts = useProvider(otherProductsProvider);
    return FadeTransition(
      opacity: animationOpacity,
      child: categorizedProducts.when(
        data: (data) => Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: StaggeredGridView.countBuilder(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: data.length ?? 0,
            itemBuilder: (context, index) {
              final product = data.elementAt(index);
              return ProductGridItem(
                product: product,
                heroTag: 'categorized_products_grid',
              );
            },
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
          ),
        ),
        loading: () => CircularProgressIndicator(),
        error: (_, __) => Text('Error'),
      ),
    );
  }
}
