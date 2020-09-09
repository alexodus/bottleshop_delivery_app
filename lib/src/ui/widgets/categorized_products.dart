import 'package:bottleshopdeliveryapp/src/services/database/product_data_service.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/product_grid_item.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/home_tab_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    final stream = context.watch<HomeTabViewModel>().products;
    return FadeTransition(
      opacity: animationOpacity,
      child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: StaggeredGridView.countBuilder(
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 4,
                itemCount: snapshot.data.size ?? 0,
                itemBuilder: (context, index) {
                  final product = context
                      .read<ProductDataService>()
                      .parseProductJson(
                          snapshot.data.docs.elementAt(index).data());
                  return FutureBuilder(
                    future: product,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      return ProductGridItem(
                        product: snapshot.data,
                        heroTag: 'categorized_products_grid',
                      );
                    },
                  );
                },
                staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              ),
            );
          }),
    );
  }
}
