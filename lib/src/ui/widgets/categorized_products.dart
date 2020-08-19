import 'package:bottleshopdeliveryapp/src/ui/widgets/product_grid_item.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/home_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategorizedProducts extends StatelessWidget {
  final Animation animationOpacity;

  const CategorizedProducts({
    Key key,
    @required this.animationOpacity,
  })  : assert(animationOpacity != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final productList =
        context.select((HomeTabViewModel viewModel) => viewModel.products);
    return Offstage(
      offstage: productList.isEmpty,
      child: FadeTransition(
        opacity: animationOpacity,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: StaggeredGridView.countBuilder(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              var product = productList.elementAt(index);
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
      ),
    );
  }
}
